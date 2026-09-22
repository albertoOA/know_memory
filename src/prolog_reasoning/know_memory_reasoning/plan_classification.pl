:- module(plan_classification,
    [ classify_all_plans_as_typical_or_atypical/0,
	  findall_plans(r),
	  classify_single_plan_as_typical_or_atypical(r)
    ]).

/** <module> Predicates for comparative reasoning with plans

@author Alberto Olivares-Alarcos
@license BSD
*/

%% findall_plans(?PlansList) 
% 
% Finds all instances of plan.
% The logic of this predicate is application dependent. 
%
%
findall_plans(PlansList) :-
	findall(P, instance_of(P, dul:'Plan'), PlansList).


%% classify_all_plans_as_typical_or_atypical()
%
% Classifies all the plans as typical or atypical.
% The logic of this predicate is application dependent.
%
%
classify_all_plans_as_typical_or_atypical() :-
	findall_plans(PlansList), 
	forall(member(P, PlansList), ignore(classify_single_plan_as_typical_or_atypical(P))).


%% classify_single_plan_as_typical_or_atypical(?P)
% ALTERNATIVE WITH LOWER SPACE AND TIME COMPLEXITY 
% THIS -> Space: O(1) Time: Worst case still is O(Nq * Np), but the average can be lower if atypical qualities are common
%
% Classifies a single plan as typical or atypical depending on 
% whether its qualities have typical values or not.
% The logic of this predicate is application dependent.
%
%
classify_single_plan_as_typical_or_atypical(P) :-
    (   % Has at least one quality?
        triple(P, _, Q0),
        instance_of(Q0, dul:'Quality')
    ->  % Check that there is NO quality Q linked to P that is NOT typical
        (   \+ (
                triple(P, _, Q),
                instance_of(Q, dul:'Quality'),
                \+ triple(Q, dul:'isClassifiedBy', ocra_common:'TypicalPlanQualityValue')
            )
        ->  kb_project(triple(P, dul:'isClassifiedBy', ocra_common:'TypicalPlan')),
            kb_project(triple(ocra_common:'TypicalPlan', dul:'classifies', P))
        ;   kb_project(triple(P, dul:'isClassifiedBy', ocra_common:'AtypicalPlan')),
            kb_project(triple(ocra_common:'AtypicalPlan', dul:'classifies', P))
        )
    ;   % No qualities at all — choose policy (here: Atypical)
        kb_project(triple(P, dul:'isClassifiedBy', ocra_common:'AtypicalPlan')),
        kb_project(triple(ocra_common:'AtypicalPlan', dul:'classifies', P))
    ).

