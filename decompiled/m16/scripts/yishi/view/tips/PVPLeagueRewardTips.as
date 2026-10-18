package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   
   public class PVPLeagueRewardTips extends BaseTip
   {
      
      private var _titleImg:Bitmap;
      
      private var _groupImg1:Bitmap;
      
      private var _groupImg2:Bitmap;
      
      private var _groupImg3:Bitmap;
      
      private var _groupImg4:Bitmap;
      
      private var _txt01:FilterFrameText;
      
      private var _txt02:FilterFrameText;
      
      private var _txt03:FilterFrameText;
      
      private var _txt04:FilterFrameText;
      
      private var _txt05:FilterFrameText;
      
      private var _txt06:FilterFrameText;
      
      private var _txt07:FilterFrameText;
      
      private var _txt08:FilterFrameText;
      
      public function PVPLeagueRewardTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleImg = ComponentFactory.Instance.creatBitmap("asset.tips.LeagueTitle");
         _groupImg1 = ComponentFactory.Instance.creatBitmap("asset.tips.LeagueGroup1");
         _groupImg2 = ComponentFactory.Instance.creatBitmap("asset.tips.LeagueGroup2");
         _groupImg3 = ComponentFactory.Instance.creatBitmap("asset.tips.LeagueGroup3");
         _groupImg4 = ComponentFactory.Instance.creatBitmap("asset.tips.LeagueGroup4");
         _txt01 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt01");
         _txt02 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt02");
         _txt03 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt03");
         _txt04 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt04");
         _txt05 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt05");
         _txt06 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt06");
         _txt07 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt07");
         _txt08 = ComponentFactory.Instance.creatComponentByStylename("tips.LeagueRewardTxt08");
         addChild(_titleImg);
         addChild(_groupImg1);
         addChild(_groupImg2);
         addChild(_groupImg3);
         addChild(_groupImg4);
         addChild(_txt01);
         addChild(_txt02);
         addChild(_txt03);
         addChild(_txt04);
         addChild(_txt05);
         addChild(_txt06);
         addChild(_txt07);
         addChild(_txt08);
         _txt01.text = "2000";
         _txt02.text = "1500";
         _txt03.text = "1200";
         _txt04.text = "900";
         _txt05.text = LanguageMgr.GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         _txt06.text = LanguageMgr.GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         _txt07.text = LanguageMgr.GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         _txt08.text = LanguageMgr.GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         _bg.width = 310;
         _bg.height = 110;
      }
      
      override protected function updateTransform() : void
      {
         if(!tipData)
         {
         }
      }
      
      override public function dispose() : void
      {
         _txt01 = null;
         _txt02 = null;
         _txt03 = null;
         _txt04 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

