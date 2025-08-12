package com.cmm;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Applicant {

    @JsonProperty("Name")
    private String name;

    @JsonProperty("Experia Score")
    private Integer experiaScore;

    @JsonProperty("Equifax Score")
    private Integer equifaxScore;

    public Applicant() {
    }

    public Applicant(String name, Integer experiaScore, Integer equifaxScore) {
        this.name = name;
        this.experiaScore = experiaScore;
        this.equifaxScore = equifaxScore;
    }

    public String getName() {
        return name;
    }

    public Integer getExperiaScore() {
        return experiaScore;
    }

    public Integer getEquifaxScore() {
        return equifaxScore;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setExperiaScore(Integer experiaScore) {
        this.experiaScore = experiaScore;
    }

    public void setEquifaxScore(Integer equifaxScore) {
        this.equifaxScore = equifaxScore;
    }
}
