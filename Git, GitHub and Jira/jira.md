# Jira

[Reference GitHub repo branches and commits to Jira issues.](https://support.atlassian.com/jira-software-cloud/docs/reference-issues-in-your-development-work/)

Om ervoor te zorgen dat code die je schrijft gelinkt kan worden aan een specifieke JIRA taak is het belangrijk dat je hier een bepaalde workflow bij volgt namelijk:  
- Vanaf je een nieuwe taak opneemt in JIRA moet je in je repository een nieuwe branch aanmaken (**aftakken van de main branch**), de naam van deze branch moet hetzelfde zijn als de JIRA issue key (bijvoorbeeld `MASTER-10`)  
- Het is de bedoeling dat je alle relevante code voor de taak in gaat committen en pushen. 
- Vanaf dat je klaar bent met deze taak moet je hiervoor een pull request aanmaken (pull request van jouw branch naar main)  
- Deze pull request mag je zelf goedkeuren (probeer wel al eens eerst te kijken of alle file changes die eraan staan voldoen aan jouw verwachtigen. Hiermee spot je vaak al voor de hand liggende fouten)  
- In JIRA kan je nu deze taak verslepen naar de done kolom  
- Nu kan je een nieuwe taak opnemen in JIRA en terug vanaf de eerste stap beginnen.

## [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) 

### Develop branch

A first branch, the development branch, h the name of the Jira issue key, e.g. `MASTERBAV-3`
When development of a version concludes, create a pull request (PR) and merge with `main`.
### Feature branches

Per feature, a new branch is created, with the develop branch as parent.
Every update on a feature get pushed to the corresponding branch.
When a feature is done, create a pull request, and merge with the develoment branch with issue key.

> Dus per feature ga je een nieuwe branch maken, een "feature branch". Bv `solid-exercise`, en hierop commit je al je aanpassingen voor deze feature.
Wanneer je rond bent maak je vervolgens een PR van de feature branch naar de main branch.
LET OP dat de branchnaam de jira issue key bevat om de link correct te kunnen leggen.
Wanneer de PR gemerged is (dat mag je zelf doen), dan mag de feature branch terug weg

### Commits with Jira

A Git commit must include the Jira issue key in order to be linked on Jira.

```
git commit -m "<issue-key> <message>"
```

#### Example

```
git commit -m "MASTERBAV-3 Jira link test with issue key in branch name and commit msg"
```

GitHub example:
![[Pasted image 20231003165009.png]]

The branch with the issue key detected, in Jira:
![[Pasted image 20231003165118.png]]

The commit with the issue key detected, in Jira:
![[Pasted image 20231003165207.png]]

The pull-request with the issue key in its title, detected in Jira:
![[Pasted image 20231003165828.png]]

Merge commit detected:
![[Pasted image 20231003170014.png]]

