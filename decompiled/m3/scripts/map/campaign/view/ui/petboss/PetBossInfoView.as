package map.campaign.view.ui.petboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PetBossInfoView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var helpBtn:BaseButton;
      
      private var todayCleanImage:Bitmap;
      
      private var bossRageImage:Bitmap;
      
      private var leftTimeImage:Bitmap;
      
      private var leftTimeText:FilterFrameText;
      
      private var rageBar:MovieClip;
      
      private var rageText:FilterFrameText;
      
      private var textVbox:VBox;
      
      private var monsterText0:FilterFrameText;
      
      private var monsterText1:FilterFrameText;
      
      private var monsterText2:FilterFrameText;
      
      private var timer:Timer;
      
      private var leftTimeNum:int;
      
      public function PetBossInfoView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.back");
         helpBtn = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.helpBtn");
         todayCleanImage = ComponentFactory.Instance.creatBitmap("asset.PetBossInfoView.todayCleanImage");
         bossRageImage = ComponentFactory.Instance.creatBitmap("asset.PetBossInfoView.bossRageImage");
         leftTimeImage = ComponentFactory.Instance.creatBitmap("asset.PetBossInfoView.leftTimeImage");
         leftTimeText = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.leftTimeText");
         rageText = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.rageText");
         textVbox = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.textVbox");
         rageBar = ComponentFactory.Instance.creatCustomObject("PetBossInfoView.rageBar");
         rageBar["halo"].visible = false;
         addChild(back);
         addChild(helpBtn);
         addChild(todayCleanImage);
         addChild(bossRageImage);
         addChild(leftTimeImage);
         addChild(textVbox);
         addChild(rageBar);
         addChild(rageText);
         addChild(leftTimeText);
         initMonsterText();
         timer = new Timer(1000);
         timer.start();
         helpBtn.tipData = LanguageMgr.GetTranslation("PetBossInfoView.helpBtn.tipdata");
      }
      
      private function initMonsterText() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this["monsterText" + _loc1_] = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.monsterText");
            (this["monsterText" + _loc1_] as FilterFrameText).setFrame(1);
            textVbox.addChild(this["monsterText" + _loc1_]);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
         helpBtn.addEventListener("click",__onHelpClick);
         if(timer)
         {
            timer.addEventListener("timer",__updateLeftTimeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
         if(helpBtn)
         {
            helpBtn.removeEventListener("click",__onHelpClick);
         }
         if(timer)
         {
            timer.stop();
            timer.removeEventListener("timer",__updateLeftTimeHandler);
         }
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("PetBossInfoView.boss.helpFrame");
         _loc2_.show();
      }
      
      private function __petBossSwitchHandler(param1:String, param2:Object) : void
      {
         if(!petBossModel.isOpen)
         {
            dispose();
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = int(petBossModel.countArr[_loc3_]);
            _loc4_ = int(petBossModel.maxCountArr[_loc3_]);
            (this["monsterText" + _loc3_] as FilterFrameText).text = LanguageMgr.GetTranslation("PetBossInfoView.monsterText" + _loc3_,_loc1_,_loc4_);
            if(_loc1_ >= _loc4_)
            {
               (this["monsterText" + _loc3_] as FilterFrameText).setFrame(2);
            }
            _loc3_++;
         }
         var _loc2_:int = Math.max(1,Math.min(100,int(petBossModel.currentRagePoint * 100 / petBossModel.maxRagePoint)));
         rageText.text = petBossModel.currentRagePoint + "/" + petBossModel.maxRagePoint;
         rageBar.gotoAndStop(_loc2_);
         leftTimeNum = petBossModel.leftTime / 1000;
      }
      
      private function __updateLeftTimeHandler(param1:TimerEvent) : void
      {
         if(leftTimeNum > 0)
         {
            leftTimeNum = leftTimeNum - 1;
            leftTimeText.text = DateFormatter.getConsortiaCountDate(leftTimeNum);
         }
         else
         {
            leftTimeText.text = "00:00:00";
            timer.stop();
            timer.removeEventListener("timer",__updateLeftTimeHandler);
         }
      }
      
      private function get petBossModel() : PetBossModel
      {
         return CampaignManager.instance.petBossModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(helpBtn)
         {
            ObjectUtils.disposeObject(helpBtn);
         }
         helpBtn = null;
         if(todayCleanImage)
         {
            ObjectUtils.disposeObject(todayCleanImage);
         }
         todayCleanImage = null;
         if(bossRageImage)
         {
            ObjectUtils.disposeObject(bossRageImage);
         }
         bossRageImage = null;
         if(leftTimeImage)
         {
            ObjectUtils.disposeObject(leftTimeImage);
         }
         leftTimeImage = null;
         if(leftTimeText)
         {
            ObjectUtils.disposeObject(leftTimeText);
         }
         leftTimeText = null;
         if(monsterText0)
         {
            ObjectUtils.disposeObject(monsterText0);
         }
         monsterText0 = null;
         if(monsterText1)
         {
            ObjectUtils.disposeObject(monsterText1);
         }
         monsterText1 = null;
         if(monsterText2)
         {
            ObjectUtils.disposeObject(monsterText2);
         }
         monsterText2 = null;
         if(rageBar)
         {
            ObjectUtils.disposeViolentMc(rageBar);
         }
         rageBar = null;
         if(rageText)
         {
            ObjectUtils.disposeObject(rageText);
         }
         rageText = null;
         if(timer)
         {
            timer.stop();
            timer = null;
         }
         if(textVbox)
         {
            ObjectUtils.disposeAllChildren(textVbox);
            ObjectUtils.disposeObject(textVbox);
            textVbox = null;
         }
         super.dispose();
      }
   }
}

