# RI-0011 - Repository Recovery Operator

**Document Identifier:** RI-0011

**Title:** Repository Recovery Operator

**Classification:** Repository Infrastructure Operator

**Layer:** Repository Infrastructure (RI)

**Status:** Draft

**Version:** 1.0

**Authority:** SMOF Constitution

---

# 1. Purpose

RI-0011 defines the controlled procedure for diagnosing and recovering a
SMOF Git repository whose references are inconsistent, missing, corrupted,
or incorrectly synchronized.

The operator preserves the existing Git object database and repository
history while restoring valid references and upstream tracking.

---

# 2. Recovery Principle

The Git object database is treated as the authoritative source of committed
repository state.

References are reconstructed only from verified commit objects and
authoritative remote references.

No repository history shall be recreated when an existing valid commit can
be recovered.

---

# 3. Recovery Lifecycle

VERIFY
  |
  v
DIAGNOSE
  |
  v
LOCATE COMMIT
  |
  v
RESTORE REFERENCE
  |
  v
SYNCHRONIZE
  |
  v
VALIDATE
  |
  v
BACKUP
  |
  v
CERTIFY

---

# 4. Diagnostic Commands

## 4.1 Repository Status

    git status

## 4.2 Current HEAD

    git rev-parse HEAD

## 4.3 Current Branch

    git branch --show-current

## 4.4 Repository Root

    git rev-parse --show-toplevel

## 4.5 Reference Database

    git show-ref

## 4.6 Remote References

    git ls-remote origin

## 4.7 Object Validation

    git cat-file -t <commit>

## 4.8 Repository Integrity

    git fsck --full

---

# 5. Reference Recovery

When a local branch reference is damaged, the verified commit hash shall be
written to the corresponding reference.

Example:

    Set-Content `
    ".git\refs\heads\release\foundation-v1.0" `
    "<verified-commit>" `
    -NoNewline

The remote-tracking reference may similarly be restored:

    Set-Content `
    ".git\refs\remotes\origin\release\foundation-v1.0" `
    "<verified-commit>" `
    -NoNewline

The commit MUST be verified before the reference is modified.

---

# 6. Upstream Restoration

After reference restoration:

    git fetch --prune origin

Then restore upstream tracking:

    git branch `
    --set-upstream-to=origin/release/foundation-v1.0 `
    release/foundation-v1.0

---

# 7. Certification Conditions

Recovery is successful only when all of the following conditions are true:

- HEAD resolves to a valid commit.
- The current branch resolves correctly.
- The upstream branch exists.
- Local and remote references agree.
- The object database contains the referenced commit.
- No required repository objects are missing.
- The working tree is clean.

---

# 8. Recovery Protection

After successful recovery, create a repository metadata backup outside the
repository working tree.

Example:

    New-Item `
    -ItemType Directory `
    -Path "C:\Users\<user>\Documents\SMOF-Backups" `
    -Force

    Copy-Item `
    ".git" `
    "C:\Users\<user>\Documents\SMOF-Backups\.git-backup-<date>" `
    -Recurse

A recovery tag shall then be created and pushed.

Example:

    git tag Repository-Recovered-v1.2

    git push origin Repository-Recovered-v1.2

The backup MUST NOT be stored inside the SMOF repository.

---

# 9. IDE Synchronization

The IDE is not authoritative for Git repository state.

If Visual Studio displays stale file states after recovery, refresh or
restart the IDE.

Git CLI state takes precedence over cached IDE decorations.

---

# 10. Safety Rules

RI-0011 shall:

- never delete valid commit objects;
- never recreate history unnecessarily;
- never force-push during recovery without explicit authorization;
- never commit .git metadata;
- never place .git backups inside the repository;
- verify a commit before assigning it to a reference;
- verify the repository after recovery.

---

# 11. Recovery Result

A successful RI-0011 execution produces:

Repository State
      |
      v
Valid References
      |
      v
Valid HEAD
      |
      v
Valid Upstream
      |
      v
Clean Working Tree
      |
      v
Recovery Certificate

---

# 12. Operational Sequence

The complete recovery sequence is:

1. Inspect repository status.
2. Inspect HEAD.
3. Inspect the current branch.
4. Inspect the affected reference.
5. Inspect the reference bytes if corruption is suspected.
6. Query the authoritative remote reference.
7. Verify the recovered commit object.
8. Restore the local branch reference.
9. Restore the remote-tracking reference if required.
10. Fetch and prune remote references.
11. Restore upstream tracking.
12. Verify all references.
13. Verify HEAD.
14. Run repository integrity checks.
15. Verify the working tree.
16. Create an external recovery backup.
17. Create and publish a recovery tag.
18. Refresh the IDE if stale Git decorations remain.
19. Issue the recovery certification.

---

# 13. Recovery Record

The recovery event that established RI-0011 involved:

Repository:
SMOF-kernel

Branch:
release/foundation-v1.0

Recovered Commit:
4a4d85a4c29a08b2ceb6f27d19133957cc217c52

Remote:
origin/release/foundation-v1.0

Recovery Tag:
Repository-Recovered-v1.2

Recovery Backup:
External to repository working tree

Final State:
Working tree clean

---

# 14. Status

RI-0011 is established as a Repository Infrastructure recovery operator
within the SMOF repository lifecycle.

Current status:

DRAFT

Next lifecycle state:

VALIDATED

Final lifecycle state:

CERTIFIED

