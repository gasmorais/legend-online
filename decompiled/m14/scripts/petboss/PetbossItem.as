package petboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetbossItem extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _name:FilterFrameText;
      
      private var _bossIcon:BaseIconView;
      
      private var _effect:NoviceBtnGlowEffect;
      
      private var _describe:FilterFrameText;
      
      private var _btn:BaseButton;
      
      private var _index:int;
      
      private var noOpenBossHead:Bitmap;
      
      private var nextBossAlert:FilterFrameText;
      
      private var leftTime:FilterFrameText;
      
      private var _timer:Timer;
      
      private var leftTimeNumber:Number;
      
      public function PetbossItem()
      {
         super();
         initView();
         initEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.bg");
         _name = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.nameText");
         _bossIcon = ComponentFactory.Instance.creatCustomObject("petBoss.icon");
         _describe = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.describeText");
         _btn = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.Btn");
         noOpenBossHead = ComponentFactory.Instance.creatBitmap("asset.petboss.noOpenHead");
         nextBossAlert = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.nextBossAlert");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("PetbossItem.leftTime");
         _effect = new NoviceBtnGlowEffect(_btn);
         _effect.stop();
         addChild(_bg);
         addChild(_name);
         addChild(_bossIcon);
         addChild(_describe);
         addChild(_btn);
         addChild(nextBossAlert);
         addChild(leftTime);
         _name.text = LanguageMgr.GetTranslation("petboss.PetbossItem.name");
         _describe.text = LanguageMgr.GetTranslation("petboss.PetbossItem.describe");
         nextBossAlert.text = LanguageMgr.GetTranslation("petboss.PetbossItem.nextBossAlert");
         _btn.visible = false;
         nextBossAlert.visible = false;
         leftTime.visible = false;
      }
      
      private function unitInit() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_describe)
         {
            _describe.dispose();
         }
         _describe = null;
         if(_btn)
         {
            _btn.dispose();
         }
         _btn = null;
         if(_effect)
         {
            _effect.dispose();
         }
         _effect = null;
         if(noOpenBossHead)
         {
            ObjectUtils.disposeObject(noOpenBossHead);
         }
         noOpenBossHead = null;
         if(nextBossAlert)
         {
            ObjectUtils.disposeObject(nextBossAlert);
         }
         nextBossAlert = null;
         if(leftTime)
         {
            ObjectUtils.disposeObject(leftTime);
         }
         leftTime = null;
         if(_bossIcon)
         {
            ObjectUtils.disposeObject(_bossIcon);
         }
         _bossIcon = null;
      }
      
      private function initEvent() : void
      {
         if(_btn)
         {
            _btn.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:GameHeroTempInfo = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
         }
         if(petBossModel.isOpen)
         {
            _btn.visible = true;
            _name.visible = true;
            nextBossAlert.visible = false;
            leftTime.visible = false;
            _effect.play();
            _loc1_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(petBossModel.heroId);
            if(_loc1_)
            {
               _name.text = _loc1_.TemplateName;
               _bossIcon.icon = IconFactory.getHeroIconByPics(_loc1_.Icon);
            }
         }
         else
         {
            _bossIcon.icon = noOpenBossHead;
            _btn.visible = false;
            _name.visible = false;
            nextBossAlert.visible = true;
            leftTime.visible = true;
            _effect.stop();
            if(!_timer)
            {
               _timer = new Timer(1000);
            }
            _timer.addEventListener("timer",__updateLeftTimeHandler);
            _timer.reset();
            _timer.start();
         }
      }
      
      private function __updateLeftTimeHandler(param1:TimerEvent) : void
      {
         var _loc2_:Number = Number(petBossModel.getNearlyOpenTimeSecond());
         if(_loc2_ > 0)
         {
            leftTime.text = DateFormatter.getConsortiaCountDate(_loc2_);
         }
         else
         {
            leftTime.text = "00:00:00";
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(petBossModel.isOpen)
         {
            if(ArmyManager.instance.thane.grades < 50)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("tasktracetip.view.PetBossTipView.LevelTips"));
            }
            else
            {
               SwitchPageHelp.walkToCrossMapTarget(petBossModel.mapId + "," + petBossModel.nodeId);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.DailyItem.PetBossUnOpen"));
         }
         _effect.stop();
         MsgMan.notifyObserver("PetEvent.PET_BOSS_ITEM_CLICK");
      }
      
      private function get petBossModel() : PetBossModel
      {
         return CampaignManager.instance.petBossModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__updateLeftTimeHandler);
            _timer = null;
         }
         unitInit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

