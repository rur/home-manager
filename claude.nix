# Claude Code configuration, shared across every machine via common.nix.
# Manages individual files under ~/.claude/ (settings, global memory, and
# room for agents/commands/skills) while leaving runtime state untouched.
{ pkgs-unstable, ... }:
{
  programs.claude-code = {
    enable = true;
    package = pkgs-unstable.claude-code;

    # ~/.claude/settings.json — managed declaratively, so it is identical on
    # every machine. Note: Claude can no longer self-edit this (e.g. changing
    # the model via /config won't persist across a rebuild).
    settings = {
      model = "opus[1m]";
    };

    # ~/.claude/CLAUDE.md — global instructions applied everywhere.
    # memory = ''
    #   # Global guidance
    # '';

    # ~/.claude/skills/commit/ — concise Conventional-Commits author.
    skills.commit = ./claude/skills/commit;

    # ~/.claude/skills/draft-prompt/ — spar + investigate, then draft a prompt.
    skills.draft-prompt = ./claude/skills/draft-prompt;

    # Drop more files in ./claude/ as these grow:
    # agents.my-agent = ./claude/agents/my-agent.md;
    # commands.deploy = ./claude/commands/deploy.md;
  };
}
