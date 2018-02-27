# Salesforce Apex Truths

The code and configuration in this project exist to validate both expected
and unexpected behavior with Salesforce Apex. Each truth will be documented
in this README with a brief explanation of the objects, triggers and other
components used to validate the truth.

As a starting point, see the "[Triggers and Order of Execution][1]" page
in the _Apex Developer Guide_.

[1]: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_triggers_order_of_execution.htm

## Truth 1

> Workflow rules are only evaluated _once_ during a DML operation, even when
a Lightning process updates the same record

Let's say you have a workflow rule that always runs on create and edit events,
and the workflow rule performs a field update.

Normally when a field update touches a record, triggers on that object are
executed a second time. If a Lightning process then updates the record,
you would expect triggers to execute once more, followed by the field update,
followed by a _final_, fourth round of trigger executions, right?

But in reality the fourth round of trigger executions never occur,
and neither does the second field update. Such is this first Apex truth.

To verify this behavior, consider the following chain of events.

1. User creates an **Apex Truth 1** record
2. `ApexTruth1Trigger` detects the `before insert` event and executes
3. `ApexTruth1Trigger` detects the `after insert` event and executes again
4. The **Set Rerun** workflow rule sets **Rerun** to `true`
5. `ApexTruth1Trigger` detects the `before update` event and executes.
   The trigger resets `IsRerun__c` to `false`.
6. `ApexTruth1Trigger` detects the `after update` event and executes again
7. The `ApexTruth1CapitalizeName` Lightning process executes, updating
   the record
8. `ApexTruth1Trigger` detects the `before update` event and executes
   for the _fifth_ time
9. `ApexTruth1Trigger` detects the `after update` event and executes again
   for the _sixth_ time

Each time `ApexTruth1Trigger` executes it creates a log entry
for each Apex Truth 1 record being processed.

At the conclusion of this chain of events, we have the following.

* An Apex Truth 1 record with a capitalized name
* 1 orphaned Log Entry record from the `before insert` trigger execution
* 5 Log Entry records under the Apex Truth 1 record
* **Rerun** showing `false` on the Apex Truth 1 record

Run `ApexTruth1Test` to confirm these outcomes.

## Truth 2

> The overridden method in a subclass is always executed when invoked,
even when the subclass instance is cast as the superclass

Let's say you want to create a subclass, maybe
to [help with Apex unit tests][1]. Regardless of the reason,
you want to know with certainty: When the subclass instance is cast
as the superclass, does the overridden method in the subclass still
get executed when called?

The `ApexTruth2MegaserviceTest.getName` test proves that the overridden
method in the subclass is _always_ executed, even when the subclass instance
is explicitly cast as the superclass.
