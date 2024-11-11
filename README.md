# Global Azure Communities

This is a repository for communities associating with Global Azure events to maintain their community page hosted on the [globalazure.net website](https://globalazure.net).

Global Azure is and always was a global for fun, lots of fun, collaboration between many different community leaders around the globe - [#GlobalAzure](https://twitter.com/search?q=%23globalazure) belongs to us all for shared joy!

We want to make sure any community who is interested in being part of #GlobalAzure have the chance to be present on our web site!

*Note: Obviously, only put public information in this public repository! NO SECRETS!*

## How to use this repo

1. Fork this repo.
2. Find the right year folder. (Hint: For Global Azure 2025 the folder is '2025'.)
3. Copy the folder "template" and give it a repo unique folder name for example with the name of your community.
   * Example: Your community name is "Foo Community in Malmö Sweden" you could make your folder name in this repo this: './2025/FooCommunity/'.
   * You pick the folder name.
   * If it is already taken you need to choose another name.
   * This means don't be mean - unless you are the Azure Community for all of Sweden maybe don't pick the folder name 'AzureSweden'. If there are many Azure communities in Sweden, you don't want them to think you are full of yourself, right? ;~)
4. In the file data.json, enter the GitHub identities of the valid folder maintainers. These are people (GitHub identities) who, in the future, will be permitted to make PRs against the repo modifying the content of your community folder.
5. If you are going to integrate your Sessionize agenda with the Global schedule:
   * fill the SessionizeEventName field with the name of your sessionize event (this is the last part of your CfP URL, or optionally the full URL of your Sessionize CfP, for example "https://sessionize.com/global-azure" or just "global-azure")
   * fill the SessionizeApiId field with the instruction provided on our blog [Sessionize integration setup for local event organizers](https://blog.globalazure.net/Blog/Post/284/Sessionize-integration-setup-for-local-event-organizers-for-2022-edition). Note: If you have configured your sessionize correctly then browsing to this url (replacing {yoursessionizeidhere} with your event sessionize id) will return valid json: [https://sessionize.com/api/v2/{yoursessionizeidhere}/view/Sessions](https://sessionize.com/api/v2/{yoursessionizeidhere}/view/Sessions).
6. Update the rest of the data in data.json to match your community. We recommend using the English country name to better integrate with the Global Azure website.
7. Your community locations are optional and will be used to build a global map with all the communities. To find your location, you can use Google Maps or a site like https://www.latlong.net. Note you can add more than one location to support communities spread over different locations.
8. Your community logo: Place a square 500x500 px .png in the folder named {folder name}.png (example from above './2025/FooCommunity/FooCommunity.png').
9. Make a PR (Pull Request)!
   * At the top of your fork there is a section for Pull Requests. You create a "New Pull Request" to signal to us that we are to review and pull your changes from your fork into our main in our repository.
   * We review the PRs manually. The process of pushing your information to our web site is *best-community-effort-based* and should be reasonably quick.

## How community PRs are reviewed

We manually review all PRs against this repo, before we merge it to main. On each merge to main a WebHook fires to automatically publish community content to the [globalazure.net website](https://globalazure.net).

The rules for PR review are:

* The Markdown file `index.md`:
  * Is [valid markdown](https://www.markdownguide.org/basic-syntax) and does not contain any strange content.
  * Texts are not offensive and align with the [Global Azure Code of Conduct](https://globalazure.net/#CoC).
* The metadata file `data.json`:
  * Contains valid json.
  * All the data.json fields are specified.
  * There are valid folder maintainers listed that map to real GitHub identities.
  * The SessionizeApiId field follows the instruction provided on our blog [Sessionize integration setup for local event organizers for 2023 edition](https://blog.globalazure.net/Blog/Post/301/Sessionize-integration-setup-for-local-event-organizers-for-2023-edition).
* Image files:
  * Represent valid and non-offensive image content.

Regards,  

[@globalazure Admins](https://twitter.com/globalazure):

[Alex Mang](https://github.com/iamalexmang),
Allen O'Neill
[David Rodríguez](https://github.com/davidjrh),
[Luce Carter](https://github.com/LuceCarter),
[Magnus M&aring;rtensson](https://github.com/noopman),
Olena Borzenko
[Rik Hepworth](https://github.com/rikhepworth)
