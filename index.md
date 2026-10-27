# Welcome to Chunan Ye's GitHub page

## About me

I am a software engineer at Microsoft in the Seattle area. Over the past few years, I have worked on a range of projects that have expanded my experience across software engineering, systems design, and developer tooling.

You can reach out to me on LinkedIn at [LinkedIn](https://www.linkedin.com/in/chunan-ye-33a688aa/).

## Azure Skills Marketplace

In late 2025, Anthropic introduced the concept of "skills" for AI systems. While the idea itself was not new, this implementation worked remarkably well and quickly drew widespread attention. We had already explored similar ideas earlier, beginning with attempts to detect user intent and load additional context for LLMs as early as the GPT-3.5 era. Those experiments were largely constrained by the models' capabilities and run outside the main execution loop. For a given user prompt, we would launch separate threads to summarize intent, extract keywords, and identify the additional context needed in later turns. Once MCP tools became available, we were able to mimic the same idea by exposing static tools that returned context without arguments. None of these earlier attempts worked as well as what Anthropic demonstrated with skills.

At that time, the development of Azure MCP had slowed after it had hundreds of tools already. Several team members, including me, shifted our attention toward Azure Skills. Based on our experience building Azure MCP, we knew that Azure was far too broad for any one team to fully master. The goal of the Azure Skills project was to create a platform that helps Azure service teams build and ship skills more effectively.

Skills are static text files. Not surprisingly, LLMs are extremely good at generating them. We went through a chaotic period of time when people created lots of skills with LLMs and uploaded them to our marketplace for distribution. We quickly hit a wall that even the descriptions of the skills in our core plugin exceeded the context budgets of agent clients, causing them to be dropped randomly. To make matters worse, we didn't have a way to answer quality questions about how well does a skill work because most were either poorly tested or not tested at all.

I managed to move the project forward by contributing in these areas:

- I created our first evaluation framework tailored to the project. It allowes us to run headless agentic evaluations against skills using predefined prompts and environment configurations. At the time of writing, this framework at least lets us validate whether a skill is invoked for the intended prompt, whether the agent loads the correct reference files, and whether it follows the skill instructions and makes the expected decisions.
- The context-overflow issue forced us to pause skill contributions for a while. I convinced my boss that placing all skills into a single plugin was not a sustainable approach. I proposed and migrated the project to a multi-plugin model that allows service teams to ship their own plugins for skills. This finally enabled us to resume contributions. The new model is not perfect. Users need to discover and install the plugins they want instead of installing one massive plugin containing everything. However, given the way agent clients work today, this is the only practical way to make skill plugins viable.
- This project relied heavily on GitHub infrastructure. I am in charge of the project as a GitHub repo admin. I manage code owners, setting branch protection rules, implementing CI/CD workflows with Copilot and Azure access, and working with GitHub Apps.

## Azure MCP

The concept of MCP servers went viral in 2025. For developers who had already been building LLM-based tools, giving an LLM access to tools was not a new idea. However, the MCP protocol managed to unify how agent clients consume tools, enabling tool developers like us to build once and make those capabilities available across mainstream clients immediately. All the tools we had developed before were limited to VS Code. This opened the opportunity to make them available to clients such as Claude Code, Cursor, and Copilot CLI as well.

A large cross-functional team was created to build the Azure MCP server. The objective of the project was to provide a single MCP server that gives LLM agents the tools needed to operate across Azure tasks. Since my team had already been developing Azure tooling, I had an opportunity to contribute to several interesting problems.

The first issue I worked on was on-behalf-of authentication for a remotely hosted Azure MCP server. This was the first time I had to study how OAuth with Microsoft Entra (formerly Azure Active Directory) works at a low level. My manager at the time gave me substantial support as I dug deep into the specifications, ran experiments, and requested testing resources. The deliverable was a simple Infrastructure-as-Code template that demonstrated how a remote Azure MCP server could be integrated with those agent platforms to perform on-behalf-of authentication. But to me, more importantly, the experience gave me a much deeper understanding of OAuth and the Microsoft Entra platform.

The second problem I tackled was extending Azure MCP to act as a proxy to other MCP servers. I was especially grateful for the knowledge I had gained from the previous task, because authentication was the biggest challenge in this work as well. This was also the point at which I discovered that Entra’s implementation conflicts with the authentication protocol used by MCP, making it impossible to use the standard MCP authentication library as-is with Entra. It turns out that the MCP protocol is intentionally stricter than the OAuth specification, and Entra operates in a less restrictive way.

## GitHub Copilot for Azure

In 2022, ChatGPT went viral. Riding that wave, in 2023 VS Code launched a chat-oriented interactive mode in the GitHub Copilot extension, allowing users to interact with an LLM by chatting. The GitHub Copilot for Azure extension evolved from that chat experience into a full-time project, and I started working on it full time in late 2024.

LLM tooling development was highly chaotic at the time. There were no established best practices, and everyone was learning new things every day. Honestly speaking, the capabilities of the LLMs available then (for example, GPT-3.5) were very limited by today’s standards. While we inevitably spent a lot of time chasing unrealistic goals, the team was able to see that LLMs plus tools were the future and focused most of our effort on developing tool-based experiences.

The concept of an extensible agent that manages tools and context was not yet mature. At that point, the chat mode in VS Code was essentially a UI wrapper around the chat completions API. The extensibility point for VS Code extensions to add LLM-based features was designed around directly invoking the chat completions API with extension-managed data. As a result, we implemented our own orchestrator on top of the VS Code extensibility point. The orchestrator could loop with the LLM to make tool calls and generate text. It was basically an agent by today’s standards. Our harness code around the orchestrator executed tool calls and fed the results back into the orchestration loop. The user experience was not great, because the orchestrator was completely isolated from the chat context in VS Code and the available tools are limited. While maintaining it, we realized how difficult it is to build a good orchestrator. Our system began reasonably well with a small number of tools, but it quickly accumulated issues as we attempted to onboard more functionality. In the end, we stopped maintaining our own orchestrator and looked for better options externally.

VS Code later introduced Agent Mode, which allows extensions to contribute tools directly. That was the right direction. We migrated the most useful tools from our old orchestrator system into Agent Mode tools. Agent Mode is a powerful coding assistant that I still use every day at the time of writing.

## Azure Storage Explorer

This was my first project after college. It is a small desktop application that serves as a client for Azure Storage services. It is not the kind of work that delivers massive, public-scale impact, but I learned a lot from it. I managed this project through its full lifecycle, including planning, development, testing, and release numerous times. I learned how to manage automation workflows in Azure DevOps pipelines and dealt with compliance requirements. I also had the opportunity to handle live incidents involving real user data and deploy mitigations. The software has a stable global user base of approximately 300,000 people. Given how limited Azure Portal is for Storage service client features, I am happen we have this project for them.

## Open source projects

[json-color-token](https://github.com/YECHUNAN/json-color-token)

The "json-color-token" extension is no longer under active development. It was created for a small need in one of my earlier project for using JSON documents to store color tokens. Being able to preview them saved a lot of time quickly spotting mis-configured ones.

## Credits

Jekyll themes provide excellent templates for turning plain Markdown into polished static websites. This page uses one of them at [Jekyll themes](https://jekyllthemes.io/).
