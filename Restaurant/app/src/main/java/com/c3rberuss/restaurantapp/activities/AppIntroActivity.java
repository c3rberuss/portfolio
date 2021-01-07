package com.c3rberuss.restaurantapp.activities;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.amn.easysharedpreferences.EasySharedPreference;
import com.c3rberuss.restaurantapp.MainActivity;
import com.c3rberuss.restaurantapp.R;
import com.github.paolorotolo.appintro.AppIntro;
import com.github.paolorotolo.appintro.AppIntroFragment;
import com.github.paolorotolo.appintro.model.SliderPage;

import butterknife.ButterKnife;

public class AppIntroActivity extends AppIntro {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Note here that we DO NOT use setContentView();

        // Add your slide fragments here.
        // AppIntro will automatically generate the dots indicator and buttons.
       /* addSlide(firstFragment);
        addSlide(secondFragment);
        addSlide(thirdFragment);
        addSlide(fourthFragment);*/

        // Instead of fragments, you can also use our default slide.
        // Just create a `SliderPage` and provide title, description, background and image.
        // AppIntro will do the rest.
        SliderPage sliderPage = new SliderPage();
        sliderPage.setTitle("Prueba 1");
        sliderPage.setDescription("Prueba 1");
        sliderPage.setImageDrawable(R.drawable.ic_favorito_activo);
        sliderPage.setBgColor(R.color.blue);


        addSlide(AppIntroFragment.newInstance(sliderPage));


        SliderPage sliderPage2 = new SliderPage();
        sliderPage2.setTitle("Prueba 2");
        sliderPage2.setDescription("Prueba 2");
        sliderPage2.setImageDrawable(R.drawable.ic_delete);
        sliderPage2.setBgColor(R.color.blue);


        addSlide(AppIntroFragment.newInstance(sliderPage2));

        // OPTIONAL METHODS
        // Override bar/separator color.
        setBarColor(getResources().getColor(R.color.blue));
        setSeparatorColor(getResources().getColor(R.color.colorPrimary));

        setNavBarColor(R.color.blue);

        // Hide Skip/Done button.
        showSkipButton(true);
        setProgressButtonEnabled(true);

    }

    @Override
    public void onSkipPressed(Fragment currentFragment) {
        super.onSkipPressed(currentFragment);
        // Do something when users tap on Skip button.
    }

    @Override
    public void onDonePressed(Fragment currentFragment) {
        super.onDonePressed(currentFragment);
        // Do something when users tap on Done button.

        EasySharedPreference.Companion.putBoolean("init", false);

        final Intent intent = new Intent(this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
        startActivity(intent);
        this.finish();
    }

    @Override
    public void onSlideChanged(@Nullable Fragment oldFragment, @Nullable Fragment newFragment) {
        super.onSlideChanged(oldFragment, newFragment);
        // Do something when the slide changes.
    }
}