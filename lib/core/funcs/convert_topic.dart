const String HEALTH_EDU_SOCIAL = "Health, Education & Social Issues";
const String ENV_AG = "Environment & Agriculture";
const String SCI_TRANS_INF = "Science, Transport and Infrastructure";
const String SECURITY_FOREIGN = "Security & Foreign Affairs";
const String ECONOMY_FINANCE = "Economy & Finance";
const String MEDIA_COMS = "Media & Communication";
const String AUS = "Australia";

String topicConverter(String tag) {
  switch(tag) {
    case "citizens": {return HEALTH_EDU_SOCIAL;}
    case "citizen": {return HEALTH_EDU_SOCIAL;}
    case "nature": {return ENV_AG;}
    case "national development": {return SCI_TRANS_INF;}
    case "national_development": {return SCI_TRANS_INF;}
    case "borders": {return SECURITY_FOREIGN;}
    case "economy": {return ECONOMY_FINANCE;}
    case "communications": {return MEDIA_COMS;}
    default: {return AUS;}
  }

}