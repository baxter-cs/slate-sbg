{$gradeLabels = array(
    "N/A" = "Standard not Applicable during the Semester"
    ,1 = "Not currently meeting expectations"
    ,2 = "Approaching expectations"
    ,3 = "Meeting expectations"
    ,4 = "Exceeding expectations"
)}


<article class="report">

    <h2>{$Report->Section->Title|escape}</h2>

    <dl>
        {if count($Report->Section->Teachers)}
            <dt class="instructor">Teacher{tif count($Report->Section->Teachers) != 1 ? s}</dt>
            {foreach item=Teacher from=$Report->Section->Teachers implode='<br />'}
                <dd class="instructor">
                    {$Teacher->FullName|escape}
                    &lt;<a href="mailto:{$Teacher->Email|escape}">{$Teacher->Email|escape}</a>&gt;
                </dd>
            {/foreach}
        {/if}

        {if $Report->Grade}
            <dt class="grade">Overall Grade</dt>
            <dd class="grade">{$Report->Grade}</dd>
        {/if}

        {$worksheet = $Report->SbgWorksheetMaster}
        {if $worksheet}
            {$standardsGrades = $worksheet->getStandardsGrades($Report)}
        {else}
            {$standardsGrades = array()}
        {/if}

        {if $worksheet && count($standardsGrades)}
            <dt class="standards">Standards</dt>
            <dd class="standards">
                <article class="standard-worksheet">
                    <table class="prompts">
                        <tbody>
                            {foreach item=Grade from=$standardsGrades}
                                <tr>
                                    <td class="prompt">{$Grade.Prompt|escape}</td>
                                    <td class="grade">
                                        {if $Grade.Grade === null}
                                            -
                                        {elseif $Grade.Grade === 0}
                                            N/A
                                        {else}
                                            {$gradeLabels[$Grade.Grade]}
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </article>
            </dd>
        {/if}

        {if $Report->SectionTermData && trim($Report->SectionTermData->TermReportNotes)}
            <dt class="comments">Section Notes</dt>
            <dd class="comments">{$Report->SectionTermData->TermReportNotes|escape|markdown}</dd>
        {/if}

        {if $Report->Assessment}
            <dt class="assessment">Assessment</dt>
            <dd class="assessment">
                {if $Report->NotesFormat == 'html'}
                    {$Report->Assessment}
                {elseif $Report->NotesFormat == 'markdown'}
                    {$Report->Assessment|escape|markdown}
                {else}
                    {$Report->Assessment|escape}
                {/if}
            </dd>
        {/if}

        {if $Report->Notes}
            <dt class="comments">Comments</dt>
            <dd class="comments">
                {if $Report->NotesFormat == 'html'}
                    {$Report->Notes}
                {elseif $Report->NotesFormat == 'markdown'}
                    {$Report->Notes|escape|markdown}
                {else}
                    {$Report->Notes|escape}
                {/if}
            </dd>
        {/if}
    </dl>
</article>