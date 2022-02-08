<div id="top"></div>
<!--
*** 
-->

[![][tags-shield]][tags-url]
![][lines-shield]
![][contributors-shield]
[![][code-climate-shield]][code-climate-url]
[![][cucumber-shield]][cucumber-url]
[![][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/gatekeeper-tamu/gatekeeper">
    <img src="app/assets/images/darkLogo.png" alt="Logo" width="150" height="120">
  </a>

  <h3 align="center">Gatekeeper</h3>

  <p align="center">
    A Ruby on Rails Subscription Manager Application
    <br />
    <a href="https://gatekeeper-tamu.herokuapp.com"><strong>Explore the app »</strong></a>
    <br />
    <br />
    <a href="https://github.com/gatekeeper-tamu/gatekeeper/issues">Report Bug</a>
    ·
    <a href="https://github.com/gatekeeper-tamu/gatekeeper/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Gatekeeper is a subscription management service that allows you to store login information for online services. It has
a number of useful features such as:
- Encrypted storage of username and password information
- Sharing of service entries between friends, family, and other groups
- Scheduleable reminders to cancel, update, renew, and more.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [Ruby](https://www.ruby-lang.org/en/)
* [Rails](https://rubyonrails.org/)
* [Devise](https://github.com/heartcombo/devise)
* [Bootstrap](https://getbootstrap.com)
* [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted)
* [kms_encrypted](https://github.com/ankane/kms_encrypted)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these steps.

### Prerequisites

To start, install the following packages: 
* npm
  ```sh
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```

* yarn -> [Link to yarn installation instructions](https://classic.yarnpkg.com/en/docs/install)

* Ruby on Rails -> [Link to Digital Ocean installation guide for Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04)

* Install PostgreSQL and binaries -> Install from [here](https://www.postgresql.org/download/) then:
  ``` sh
  sudo apt install libpq-dev
  ```

* Install bundler
  ```sh
  gem install bundler
  ```

* Install the Heroku CLI -> [Link to instructions](https://devcenter.heroku.com/articles/heroku-cli)

* Setup Google Oauth access -> [Link to setup Google Auth project](https://support.google.com/cloud/answer/6158849?hl=en)

* Setup a [AWS KMS master key](https://console.aws.amazon.com/kms/home#/kms/keys) using [AWS setup instructions for the kms_encryped gem](https://github.com/ankane/kms_encrypted#aws-kms)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/gatekeeper-tamu/gatekeeper.git
   ```
2. Navigate to directory and install gems
    ```sh
    cd gatekeeper
    bundle install
    ```
3. Setup environment variables
    - Create `.env` file in the root directory with the following:
      ```sh
      GOOGLE_CLIENT_ID="insert_google_client_id_here"
      GOOGLE_CLIENT_SECRET="insert_google_client_secret_here"
      AWS_ACCESS_KEY_ID="..."
      AWS_SECRET_ACCESS_KEY="..."
      KMS_KEY_ID="..."
      AWS_REGION="..."
      ```
4. Create or set heroku project
    ```sh
    heroku create
    ```
5. Setup the database
    - Make sure postgres is started and your user is created/has db access
      ```sh
      sudo service postgresql start
      sudo -u postgres createuser -s <your username> -P
      ```
    - Intitialize db
      ```sh
      rake db:setup
      ```
6. Setup webpacker
    ```sh
    bundle exec rake webpacker:install
    ```
7. Run the app:
    - To run locally:
      ```sh
      heroku local
      ```
      Navigate to `localhost:5000` to see the app.
    - To deploy to heroku:
        - Export all environment variables from `.env` file
          ```sh
          heroku config:set ENVIRONMENT_VARIABLE="value_here"
          ```
        - Set git remote for heroku:
          ```sh
          heroku git:remote -a <your app name>
          ```
        - Push to heroku
          ```sh
          git push heroku master
          ```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ROADMAP -->
## Roadmap

- [x] User Login
- [X] Add/Remove/Update Subscription Entries
- [ ] Share Subscriptions
- [ ] Create Groups
- [ ] Setup Cancellation/Renewal Reminders
- [ ] Configure Group/Personal Settings
- [ ] See Statistics on Monthly Costs/Usage Data
- [ ] Explore Subscription Services and Deals
- [ ] Send Temporary Account Access to Non-Users

See the [open issues](https://github.com/gatekeeper-tamu/gatekeeper/issues) or the [pivotal tracker](https://www.pivotaltracker.com/n/projects/2547056) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Rebecca McFadden - rmcfadden@tamu.edu

Project Link: [https://github.com/gatekeeper-tamu/gatekeeper](https://github.com/gatekeeper-tamu/gatekeeper)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

TODO

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/gatekeeper-tamu/gatekeeper.svg
[contributors-url]: https://github.com/gatekeeper-tamu/gatekeeper/graphs/contributors
[lines-shield]: https://img.shields.io/tokei/lines/github/gatekeeper-tamu/gatekeeper
[code-climate-shield]: https://img.shields.io/codeclimate/maintainability/gatekeeper-tamu/gatekeeper
[code-climate-url]: https://codeclimate.com/github/gatekeeper-tamu/gatekeeper
[stars-shield]: https://img.shields.io/github/stars/gatekeeper-tamu/gatekeeper.svg
[stars-url]: https://github.com/gatekeeper-tamu/gatekeeper/stargazers
[tags-shield]: https://img.shields.io/github/v/tag/gatekeeper-tamu/gatekeeper
[tags-url]: https://github.com/gatekeeper-tamu/gatekeeper/tags
[license-shield]: https://img.shields.io/github/license/gatekeeper-tamu/gatekeeper
[license-url]: https://github.com/gatekeeper-tamu/gatekeeper/blob/master/LICENSE
[cucumber-shield]: https://messages.cucumber.io/api/report-collections/f2e8b2b8-bbb2-41b7-96d9-bc092f29c77d/badge
[cucumber-url]: https://reports.cucumber.io/report-collections/f2e8b2b8-bbb2-41b7-96d9-bc092f29c77d
