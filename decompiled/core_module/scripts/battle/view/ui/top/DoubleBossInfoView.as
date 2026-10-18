package battle.view.ui.top
{
   import battle.BattleManager;
   import battle.view.ui.BossStripUIView;
   import battle.view.ui.HeroRoleHeadView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class DoubleBossInfoView extends Sprite
   {
      
      private var _doubleBossAsset:MovieClip;
      
      protected var _rightHead1:HeroRoleHeadView;
      
      protected var _rightHp1:BossStripUIView;
      
      protected var _info1:HeroRoleInfo;
      
      public var nameTxt1:TextField;
      
      private var _numGradeSprite1:Component;
      
      protected var _rightHead2:HeroRoleHeadView;
      
      protected var _rightHp2:BossStripUIView;
      
      protected var _info2:HeroRoleInfo;
      
      public var nameTxt2:TextField;
      
      private var _numGradeSprite2:Component;
      
      public function DoubleBossInfoView()
      {
         super();
      }
      
      public function setInfo(param1:HeroRoleInfo, param2:HeroRoleInfo) : void
      {
         _info1 = param1;
         _info2 = param2;
         initView();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function __onStage(param1:Event) : void
      {
         NotificationManager.instance.removeEventListener("TransSceneEffectComplete",__onStage);
         if(_doubleBossAsset)
         {
            _doubleBossAsset["left_BossBlood"].gotoAndPlay(1);
            _doubleBossAsset["right_BossBlood"].gotoAndPlay(1);
            addChild(_doubleBossAsset);
         }
      }
      
      public function setTotalHp(param1:Number, param2:Number) : void
      {
         if(_rightHp1)
         {
            _rightHp1.maxValue = param1;
         }
         if(_rightHp2)
         {
            _rightHp2.maxValue = param2;
         }
      }
      
      public function setCurrentHp(param1:Number, param2:Number) : void
      {
         if(_info1.isLiving)
         {
            if(_rightHp1.isDie)
            {
               _rightHp1 = new BossStripUIView(BattleModel.getBossHpStripNum(_info1.heroInfo.templateId),0,16275472,true,1);
               _doubleBossAsset["left_BossBlood"].blood.r_hp_pos.addChild(_rightHp1);
               _rightHp1.getView().scaleX = _rightHp1.getView().scaleX * -1;
               _rightHp1.getView().width = 397;
               _rightHp1.getView().x = _rightHp1.getView().x + (_rightHp1.getView().width + 5);
               _rightHp1.maxValue = BattleManager.getInstance().battleModel.armyInfoRight.getBossesTotalHpByInfo(_info1);
            }
            _rightHp1.currentValue = param1;
         }
         else
         {
            _rightHp1.dispose();
         }
         if(_info2.isLiving)
         {
            if(_rightHp2.isDie)
            {
               _rightHp2 = new BossStripUIView(BattleModel.getBossHpStripNum(_info2.heroInfo.templateId),0,16275472);
               _doubleBossAsset["right_BossBlood"].blood.r_hp_pos.addChild(_rightHp2);
               _rightHp2.getView().scaleX = _rightHp2.getView().scaleX * -1;
               _rightHp2.getView().width = 397;
               _rightHp2.getView().x = _rightHp2.getView().x + (_rightHp2.getView().width + 5);
               _rightHp2.maxValue = BattleManager.getInstance().battleModel.armyInfoRight.getBossesTotalHpByInfo(_info2);
            }
            _rightHp2.currentValue = param2;
         }
         else
         {
            _rightHp2.dispose();
         }
      }
      
      override public function get width() : Number
      {
         return 1000;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         NotificationManager.instance.addEventListener("TransSceneEffectComplete",__onStage);
         if(!_doubleBossAsset)
         {
            _doubleBossAsset = ComponentFactory.Instance.creatCustomObject("asset.core.boubleBossHPAsset");
         }
         _doubleBossAsset.mouseChildren = _doubleBossAsset.mouseEnabled = false;
         _doubleBossAsset.scrollRect = null;
         _doubleBossAsset.gotoAndStop(_doubleBossAsset.totalFrames);
         var _loc4_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc4_ && _loc4_.transSceneEffectComplete)
         {
            addChild(_doubleBossAsset);
         }
         else
         {
            _doubleBossAsset.gotoAndStop(_doubleBossAsset.totalFrames);
            _doubleBossAsset["left_BossBlood"].gotoAndStop(_doubleBossAsset["left_BossBlood"].totalFrames);
            _doubleBossAsset["right_BossBlood"].gotoAndStop(_doubleBossAsset["right_BossBlood"].totalFrames);
            NotificationManager.instance.addEventListener("TransSceneEffectComplete",__onStage);
         }
         if(_rightHead1)
         {
            _rightHead1.dispose();
         }
         _rightHead1 = null;
         var _loc5_:Rectangle = new Rectangle(0,0,78,78);
         _rightHead1 = new HeroRoleHeadView(_doubleBossAsset["left_BossBlood"].head.r_head,_loc5_,-1);
         _rightHead1.info = _info1;
         if(_rightHead2)
         {
            _rightHead2.dispose();
         }
         _rightHead2 = null;
         _rightHead2 = new HeroRoleHeadView(_doubleBossAsset["right_BossBlood"].head.r_head,_loc5_,-1);
         _rightHead2.info = _info2;
         if(_rightHp1)
         {
            _rightHp1.dispose();
         }
         _rightHp1 = null;
         _rightHp1 = new BossStripUIView(BattleModel.getBossHpStripNum(_info1.heroInfo.templateId),0,16275472,true,1);
         _doubleBossAsset["left_BossBlood"].blood.r_hp_pos.addChild(_rightHp1);
         _rightHp1.getView().scaleX = _rightHp1.getView().scaleX * -1;
         _rightHp1.getView().width = 397;
         _rightHp1.getView().x = _rightHp1.getView().x + (_rightHp1.getView().width + 5);
         if(_rightHp2)
         {
            _rightHp2.dispose();
         }
         _rightHp2 = null;
         _rightHp2 = new BossStripUIView(BattleModel.getBossHpStripNum(_info2.heroInfo.templateId),0,16275472);
         _doubleBossAsset["right_BossBlood"].blood.r_hp_pos.addChild(_rightHp2);
         _rightHp2.getView().scaleX = _rightHp2.getView().scaleX * -1;
         _rightHp2.getView().width = 397;
         _rightHp2.getView().x = _rightHp2.getView().x + (_rightHp2.getView().width + 5);
         var _loc1_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_info1.heroInfo.templateId);
         _loc3_ = _loc1_.Grades;
         if(!_numGradeSprite1)
         {
            _numGradeSprite1 = new Component();
            _doubleBossAsset["left_BossBlood"].head.r_grade.addChild(_numGradeSprite1);
         }
         var _loc2_:BitmapData = ClassUtils.CreatInstance("asset.battle.BossGradeNumAsset") as BitmapData;
         NumberViewUtils.printNumber(_loc3_,_numGradeSprite1,_loc2_,"1234567890",-3);
         _numGradeSprite1.scaleX = -1;
         _numGradeSprite1.x = _numGradeSprite1.displayWidth * 1.5;
         _numGradeSprite1.y = _numGradeSprite1.displayHeight * 0.5;
         nameTxt1 = _doubleBossAsset["left_BossBlood"].head.r_name;
         nameTxt1.text = _info1.heroInfo.nickName;
         _loc1_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_info2.heroInfo.templateId);
         _loc3_ = _loc1_.Grades;
         if(!_numGradeSprite2)
         {
            _numGradeSprite2 = new Component();
            _doubleBossAsset["right_BossBlood"].head.r_grade.addChild(_numGradeSprite2);
         }
         NumberViewUtils.printNumber(_loc3_,_numGradeSprite2,_loc2_,"1234567890",-3);
         _numGradeSprite2.x = -_numGradeSprite2.displayWidth * 0.5;
         _numGradeSprite2.y = -_numGradeSprite2.displayHeight * 0.5;
         _loc2_.dispose();
         nameTxt2 = _doubleBossAsset["right_BossBlood"].head.r_name;
         nameTxt2.text = _info2.heroInfo.nickName;
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("TransSceneEffectComplete",__onStage);
         _info1 = null;
         _info2 = null;
         nameTxt1 = null;
         nameTxt2 = null;
         if(_rightHead1)
         {
            _rightHead1.parent.removeChild(_rightHead1);
            _rightHead1.dispose();
            _rightHead1 = null;
         }
         if(_rightHead2)
         {
            _rightHead2.parent.removeChild(_rightHead2);
            _rightHead2.dispose();
            _rightHead2 = null;
         }
         if(_rightHp1)
         {
            if(_rightHp1.getView() && _rightHp1.getView().parent)
            {
               _rightHp1.getView().parent.removeChild(_rightHp1.getView());
            }
            _rightHp1.dispose();
            _rightHp1 = null;
         }
         if(_rightHp2)
         {
            if(_rightHp2.getView() && _rightHp2.getView().parent)
            {
               _rightHp2.getView().parent.removeChild(_rightHp2.getView());
            }
            _rightHp2.dispose();
            _rightHp2 = null;
         }
         if(_doubleBossAsset)
         {
            ObjectUtils.disposeViolentMc(_doubleBossAsset);
            _doubleBossAsset = null;
         }
         if(_numGradeSprite1)
         {
            ObjectUtils.disposeAllChildren(_numGradeSprite1);
            _numGradeSprite1 = null;
         }
         if(_numGradeSprite2)
         {
            ObjectUtils.disposeAllChildren(_numGradeSprite2);
            _numGradeSprite2 = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

