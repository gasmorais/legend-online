package battle.view.ui.top
{
   import battle.BattleManager;
   import battle.view.ui.BossStripUIView;
   import battle.view.ui.HeroRoleHeadView;
   import battle.view.ui.IHpStrip;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import map.campaign.CampaignManager;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.BaseManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.WorldBossHelper;
   
   public class BossInfoView extends Sprite implements Disposeable
   {
      
      protected var _assetRight:MovieClip;
      
      protected var _nameInfoTxt:FilterFrameText;
      
      protected var _rightHead:HeroRoleHeadView;
      
      protected var _rightHp:IHpStrip;
      
      protected var _info:HeroRoleInfo;
      
      public var nameTxt:TextField;
      
      public var bloodTxt:TextField;
      
      private var numGradeSprite:Component;
      
      private var bossNameBg:ScaleBitmapImage;
      
      private var tempEffectList:Array = [];
      
      public function BossInfoView()
      {
         super();
      }
      
      private function __onStage(param1:Event) : void
      {
         NotificationManager.instance.removeEventListener("TransSceneEffectComplete",__onStage);
         if(_assetRight)
         {
            _assetRight.gotoAndPlay(1);
            addChild(_assetRight);
         }
      }
      
      public function get assetRight() : MovieClip
      {
         return _assetRight;
      }
      
      public function set assetRight(param1:MovieClip) : void
      {
         _assetRight = param1;
      }
      
      public function get nameInfoTxt() : FilterFrameText
      {
         return _nameInfoTxt;
      }
      
      public function set nameInfoTxt(param1:FilterFrameText) : void
      {
         _nameInfoTxt = param1;
      }
      
      public function setInfo(param1:HeroRoleInfo) : void
      {
         if(_info && _info.heroInfo.grades > param1.heroInfo.grades)
         {
            return;
         }
         _info = param1;
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      public function setTotalHp(param1:Number) : void
      {
         _rightHp.maxValue = param1;
      }
      
      public function setCurrentHp(param1:Number) : void
      {
         if(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.battleType == 17 && BaseManager.instance.wordBossInvincibleState)
         {
            _rightHp.currentValue = _rightHp.maxValue;
            return;
         }
         _rightHp.currentValue = param1;
      }
      
      public function updateWorldBossHp(param1:Number) : void
      {
         if(param1 == 0)
         {
            return;
         }
         setCurrentHp(_rightHp.currentValue + param1);
         playWorldBossHpEffect(param1);
      }
      
      private function playWorldBossHpEffect(param1:Number) : void
      {
         var bm:Bitmap;
         var effect:MovieClip;
         var updated:Number = param1;
         var endFrame:* = function():void
         {
            effect.stop();
            effect.addFrameScript(effect.totalFrames - 1,null);
            ObjectUtils.removeChildAllChildren(blood);
            if(effect.parent)
            {
               effect.parent.removeChild(effect);
               if(tempEffectList)
               {
                  tempEffectList.push(effect);
               }
            }
         };
         var blood:Sprite = new Sprite();
         if(updated > 0)
         {
            bm = ComponentFactory.Instance.creat("asset.battle.AddHpNumAsset");
            NumberViewUtils.getNumberView(Math.abs(updated),blood,bm.bitmapData,55,55,35,55,"0123456789.",1);
         }
         else
         {
            bm = ComponentFactory.Instance.creat("asset.battle.ExtraNumberAsset");
            NumberViewUtils.getNumberView(Math.abs(updated),blood,bm.bitmapData,55,55,35,55,"0123456789.",1);
         }
         ObjectUtils.disposeObject(bm);
         bm = null;
         blood.mouseChildren = blood.mouseEnabled = false;
         effect = ComponentFactory.Instance.creat("asset.battle.WorldBossBloodMC");
         blood.x = -blood.width * 0.5;
         if(updated > 0)
         {
            effect.x = 750;
         }
         else
         {
            effect.x = 600;
         }
         effect.y = 30;
         effect.container.addChild(blood);
         effect.addFrameScript(effect.totalFrames - 1,endFrame);
         effect.mouseChildren = effect.mouseEnabled = false;
         addChild(effect);
      }
      
      override public function get width() : Number
      {
         return 986;
      }
      
      protected function initView() : void
      {
         var _loc3_:int = 0;
         if(!_assetRight)
         {
            _assetRight = ComponentFactory.Instance.creatCustomObject("asset.battle.BossShowRightAsset");
         }
         _assetRight.mouseChildren = _assetRight.mouseEnabled = false;
         _assetRight.scrollRect = null;
         _assetRight.y = -10;
         var _loc4_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc4_ && _loc4_.transSceneEffectComplete)
         {
            addChild(_assetRight);
         }
         else
         {
            _assetRight.gotoAndStop(_assetRight.totalFrames);
            NotificationManager.instance.addEventListener("TransSceneEffectComplete",__onStage);
         }
         bloodTxt = _assetRight.blood.r_hptxt;
         bloodTxt.visible = false;
         if(_rightHead)
         {
            _rightHead.dispose();
         }
         _rightHead = null;
         var _loc5_:Rectangle = new Rectangle(0,0,78,78);
         _rightHead = new HeroRoleHeadView(_assetRight.head.r_head,_loc5_,-1);
         _rightHead.info = _info;
         _rightHead.y = -_loc5_.height;
         if(_rightHp)
         {
            _rightHp.dispose();
         }
         _rightHp = null;
         _rightHp = new BossStripUIView(BattleModel.getBossHpStripNum(_info.heroInfo.templateId),0,16275472);
         _assetRight.blood.r_hp_pos.addChild(_rightHp);
         _rightHp.getView().scaleX = _rightHp.getView().scaleX * -1;
         _rightHp.getView().width = 397;
         _rightHp.getView().x = _rightHp.getView().x + (_rightHp.getView().width + 5);
         var _loc1_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_info.heroInfo.templateId);
         if(isConsortiaEmeDream)
         {
            _loc3_ = ConsortiaManager.instance.model.emeDreamInfo.callGrade;
         }
         else if(_loc1_)
         {
            _loc3_ = _loc1_.Grades;
         }
         if(!numGradeSprite)
         {
            numGradeSprite = new Component();
            _assetRight.head.r_grade.addChild(numGradeSprite);
         }
         var _loc2_:BitmapData = ClassUtils.CreatInstance("asset.battle.BossGradeNumAsset") as BitmapData;
         NumberViewUtils.printNumber(_loc3_,numGradeSprite,_loc2_,"1234567890",-3);
         numGradeSprite.x = -numGradeSprite.displayWidth * 0.5;
         numGradeSprite.y = -numGradeSprite.displayHeight * 0.5;
         _loc2_.dispose();
         nameTxt = _assetRight.head.r_name;
         nameTxt.wordWrap = true;
         nameTxt.text = _info.heroInfo.nickName;
         if(!bossNameBg)
         {
            bossNameBg = ComponentFactory.Instance.creatComponentByStylename("core.boss.bossNameBg");
         }
         _assetRight.head.addChildAt(bossNameBg,1);
         nameTxt.y = bossNameBg.y + 22;
         nameTxt.height = nameTxt.textHeight + 20;
         bossNameBg.height = 22 + nameTxt.textHeight + 20;
      }
      
      private function get isConsortiaEmeDream() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "BATTLE_SCENE" && BattleManager.getInstance().battleModel.battleType == 309)
         {
            _loc1_ = true;
         }
         else if(WorldBossHelper.checkConsortiaEmeDream(CampaignManager.instance.mapId))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("TransSceneEffectComplete",__onStage);
         if(_assetRight)
         {
            ObjectUtils.disposeViolentMc(_assetRight);
         }
         _assetRight = null;
         if(_nameInfoTxt)
         {
            ObjectUtils.disposeObject(_nameInfoTxt);
         }
         _nameInfoTxt = null;
         if(_rightHead)
         {
            ObjectUtils.disposeObject(_rightHead);
         }
         _rightHead = null;
         if(_rightHp)
         {
            ObjectUtils.disposeObject(_rightHp.getView());
            _rightHp.dispose();
            _rightHp = null;
         }
         if(nameTxt)
         {
            ObjectUtils.disposeObject(nameTxt);
         }
         nameTxt = null;
         if(bloodTxt)
         {
            ObjectUtils.disposeObject(bloodTxt);
         }
         bloodTxt = null;
         if(bossNameBg)
         {
            ObjectUtils.disposeObject(bossNameBg);
         }
         bossNameBg = null;
         if(numGradeSprite)
         {
            ObjectUtils.disposeAllChildren(numGradeSprite);
            ObjectUtils.disposeObject(numGradeSprite);
            numGradeSprite = null;
         }
         for each(var _loc1_:MovieClip in tempEffectList)
         {
            ObjectUtils.disposeViolentMc(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         if(tempEffectList)
         {
            tempEffectList.splice(0,tempEffectList.length);
         }
         tempEffectList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

