package battle.view.ui.top
{
   import battle.BattleManager;
   import battle.view.ui.BossStripUIView;
   import battle.view.ui.HeroRoleHeadView;
   import battle.view.ui.IHpStrip;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class BossInfoViewII extends Sprite
   {
      
      private var _showReduceEffect:Boolean = false;
      
      private var _curRoleInfo:HeroRoleInfo;
      
      private var _bossInfoViewResouce:MovieClip;
      
      private var _headView:HeroRoleHeadView;
      
      private var _hpView:IHpStrip;
      
      private var _bloodTxt:TextField;
      
      private var _nameTxt:TextField;
      
      private var _gradeTxt:TextField;
      
      private var _gradeDisplayobject:Sprite;
      
      private var _effectContainerMc:MovieClip;
      
      private var _numBmd:BitmapData;
      
      private var _resourceName:String;
      
      private var _numBmp:Bitmap;
      
      private var _addNamePos:Point = new Point();
      
      private const HEAD_VIEW_SIZE:uint = 78;
      
      private const EFFECT_POS_X:uint = 600;
      
      public function BossInfoViewII(param1:MovieClip, param2:String)
      {
         super();
         _resourceName = param2;
         initView(param1);
      }
      
      private function initView(param1:MovieClip) : void
      {
         var myBattleModle:BattleModel;
         var myResource:MovieClip;
         var bossInfoViewResouce:MovieClip = param1;
         _numBmd = ClassUtils.CreatInstance("asset.battle.BossGradeNumAsset") as BitmapData;
         _bossInfoViewResouce = bossInfoViewResouce;
         addChild(_bossInfoViewResouce);
         _bossInfoViewResouce.gotoAndStop(1);
         myBattleModle = BattleManager.getInstance().battleModel;
         if(myBattleModle != null && myBattleModle.transSceneEffectComplete)
         {
            _bossInfoViewResouce.play();
         }
         else
         {
            NotificationManager.instance.addEventListener("TransSceneEffectComplete",function(param1:Event):void
            {
               NotificationManager.instance.removeEventListener("TransSceneEffectComplete",arguments.callee);
               _bossInfoViewResouce.play();
            });
         }
         myResource = resourceAdapterHandler(_bossInfoViewResouce);
         _nameTxt = myResource["head"]["r_name"];
         _bloodTxt = myResource["blood"]["r_hptxt"];
         _bloodTxt.visible = false;
         _gradeTxt = myResource["head"]["r_level"];
         _gradeDisplayobject = new Sprite();
         (myResource["head"]["r_grade"] as MovieClip).addChild(_gradeDisplayobject);
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function resourceAdapterHandler(param1:MovieClip, param2:Boolean = false) : MovieClip
      {
         var targetObj:MovieClip;
         var resourceMc:MovieClip = param1;
         var toCreateHpView:Boolean = param2;
         var initHeadViewHandler:* = function(param1:uint, param2:uint):void
         {
            var _loc3_:Rectangle = null;
            if(_headView == null)
            {
               _loc3_ = new Rectangle(0,0,param1,param2);
               _headView = new HeroRoleHeadView(targetObj["head"]["r_head"],_loc3_,-1);
               _headView.y = -_loc3_.height;
            }
         };
         var bossBloodBarHandler:* = function(param1:String, param2:uint, param3:String, param4:String):void
         {
            showReduceEffect = true;
            _effectContainerMc.x = 0;
            targetObj = resourceMc["bloodBar_mc"];
            if(_nameTxt != null)
            {
            }
            if(toCreateHpView)
            {
               if(_hpView != null)
               {
                  _hpView.dispose();
               }
               _hpView = new BossStripUIView(BattleModel.getBossHpStripNum(_curRoleInfo.heroInfo.templateId),0,16275472,true,-1,param3,param4);
               (_hpView as BossStripUIView).setStrpNumPos((_hpView as BossStripUIView).width,-25);
            }
         };
         switch(_resourceName)
         {
            case "asset.battle.LiteBossBloodBar_0":
               bossBloodBarHandler("asset.battle.LiteBossBloodBmd_0",0,"asset.battle.BossHpStripAsset_0","asset.battle.BossHpStripBgAsset_1");
               initHeadViewHandler(78 * 0.6,78 * 0.6);
               break;
            case "asset.battle.LiteBossBloodBar_1":
               bossBloodBarHandler("asset.battle.LiteBossBloodBmd_1",10,"asset.battle.BossHpStripAsset_1",null);
               initHeadViewHandler(78 * 0.5,78 * 0.5);
               break;
            default:
               showReduceEffect = true;
               _effectContainerMc.x = 600;
               targetObj = resourceMc;
               if(toCreateHpView)
               {
                  if(_hpView != null)
                  {
                     _hpView.dispose();
                  }
                  _hpView = new BossStripUIView(BattleModel.getBossHpStripNum(_curRoleInfo.heroInfo.templateId),0,16275472,true,-1);
               }
               initHeadViewHandler(78,78);
         }
         return targetObj;
      }
      
      public function updateUIByHeroInfo(param1:HeroRoleInfo, param2:uint, param3:uint) : void
      {
         _curRoleInfo = param1;
         var _loc4_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1.heroInfo.templateId);
         _nameTxt.text = param1.heroInfo.nickName;
         _headView.info = param1;
         if(_hpView != null)
         {
            _hpView.dispose();
            _hpView = null;
         }
         var _loc5_:MovieClip = resourceAdapterHandler(_bossInfoViewResouce,true);
         (_loc5_["blood"]["r_hp_pos"] as MovieClip).addChild(_hpView as DisplayObject);
         _hpView.maxValue = param2;
         _hpView.currentValue = param3;
         _hpView.getView().scaleX = -1;
         _hpView.getView().x = _hpView.getView().x + _hpView.getView().width;
         if(_gradeTxt != null)
         {
            _gradeTxt.text = _loc4_.Grades.toString();
         }
         else
         {
            NumberViewUtils.printNumber(_loc4_.Grades,_gradeDisplayobject,_numBmd,"1234567890",-3);
            _gradeDisplayobject.x = -_numBmd.width * 0.5 + 88;
            _gradeDisplayobject.y = -_numBmd.height * 0.5;
         }
      }
      
      public function playDamageNumEffect(param1:Number) : void
      {
         var bloodContainer:Sprite;
         var num:Number = param1;
         if(num > 0 && _showReduceEffect)
         {
            bloodContainer = new Sprite();
            NumberViewUtils.getNumberView(num,bloodContainer,_numBmp.bitmapData,55,55,35,55,"0123456789.",1);
            _effectContainerMc.gotoAndStop(1);
            (_effectContainerMc["container"] as MovieClip).addChild(bloodContainer);
            _effectContainerMc.play();
            _effectContainerMc.addFrameScript(_effectContainerMc.totalFrames - 1,function():void
            {
               _effectContainerMc.stop();
               if(bloodContainer.parent != null)
               {
                  bloodContainer.parent.removeChild(bloodContainer);
               }
            });
         }
      }
      
      public function dispose() : void
      {
         if(_headView)
         {
            _headView.dispose();
         }
         _headView = null;
         if(_hpView)
         {
            _hpView.dispose();
         }
         _hpView = null;
         if(_numBmd)
         {
            _numBmd.dispose();
         }
         _numBmd = null;
         ObjectUtils.disposeAllChildren(this);
         _curRoleInfo = null;
         _bossInfoViewResouce = null;
         if(_bloodTxt)
         {
            ObjectUtils.disposeObject(_bloodTxt);
         }
         _bloodTxt = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_gradeTxt)
         {
            ObjectUtils.disposeObject(_gradeTxt);
         }
         _gradeTxt = null;
         if(_gradeDisplayobject)
         {
            ObjectUtils.disposeObject(_gradeDisplayobject);
         }
         _gradeDisplayobject = null;
         if(_effectContainerMc)
         {
            ObjectUtils.disposeObject(_effectContainerMc);
         }
         _effectContainerMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get hpView() : DisplayObject
      {
         return _hpView as DisplayObject;
      }
      
      public function get bloodTxt() : TextField
      {
         return _bloodTxt;
      }
      
      public function get bossInfoViewResouce() : MovieClip
      {
         return _bossInfoViewResouce;
      }
      
      public function set showReduceEffect(param1:Boolean) : void
      {
         if(_showReduceEffect != param1)
         {
            _showReduceEffect = param1;
            if(param1)
            {
               _numBmp = ComponentFactory.Instance.creat("asset.battle.ExtraNumberAsset");
               _effectContainerMc = ComponentFactory.Instance.creat("asset.battle.WorldBossBloodMC");
               _effectContainerMc.mouseChildren = _effectContainerMc.mouseEnabled = false;
               addChild(_effectContainerMc);
            }
            else
            {
               if(_numBmp != null)
               {
                  _numBmp.bitmapData.dispose();
                  _numBmp = null;
               }
               if(_effectContainerMc != null)
               {
                  if(_effectContainerMc.parent != null)
                  {
                     _effectContainerMc.parent.removeChild(_effectContainerMc);
                  }
                  _effectContainerMc = null;
               }
            }
         }
      }
   }
}

