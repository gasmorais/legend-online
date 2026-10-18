package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import mvc.module.armyII.UserArmy;
   import mvc.module.secret.SecretAdventureModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.SecretAdventerManager;
   import yishi.scene.SceneManager;
   
   public class HPExperenceView extends Component
   {
      
      private var _hpValue:FilterFrameText;
      
      private var _hpProgress:Bitmap;
      
      private var _hpProgressBg:Bitmap;
      
      private var _hpAlertMc:MovieClip;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:UserArmy;
      
      private var _percent:Number;
      
      public function HPExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _hpValue = ComponentFactory.Instance.creatComponentByStylename("resourceBar.HpValueTxt");
         _hpValue.text = "1200 / 1200";
         _hpProgress = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.HpProgress");
         _hpAlertMc = ComponentFactory.Instance.creatCustomObject("resourcesBar.HpAlertMc");
         addChild(_hpProgress);
         addChild(_hpValue);
         _mask = createShape();
         addChild(_mask);
         _hpProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(_hpProgress.x,_hpProgress.y,_hpProgress.width,_hpProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _hpProgress.width * -1;
         return _loc1_;
      }
      
      private function setHpAlertMcVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(!_hpAlertMc.parent)
            {
               addChildAt(_hpAlertMc,0);
               _hpAlertMc.gotoAndPlay(1);
            }
         }
         else if(_hpAlertMc.parent)
         {
            _hpAlertMc.gotoAndStop(1);
            removeChild(_hpAlertMc);
         }
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _hpValue.text = currentThane.hp + " / " + currentThane.attackProrerty.totalLive;
            _percent = currentThane.hp / currentThane.attackProrerty.totalLive;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
            _percent < 0.1 ? setHpAlertMcVisible(true) : setHpAlertMcVisible(false);
         }
         else
         {
            _hpValue.text = "0 / 0";
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
            setHpAlertMcVisible(true);
         }
      }
      
      private function refreshSecretView() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(_data)
         {
            _loc2_ = model.frameInfo.currHp;
            _loc1_ = model.frameInfo.initHp;
            _hpValue.text = _loc2_ + " / " + _loc1_;
            _percent = _loc2_ / _loc1_;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
            _percent < 0.1 ? setHpAlertMcVisible(true) : setHpAlertMcVisible(false);
         }
         else
         {
            _hpValue.text = "0 / 0";
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
            setHpAlertMcVisible(true);
         }
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      private function get currentThane() : ThaneInfo
      {
         return _data.baseHero;
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "SECRET_ADVENTURE_SCENE")
         {
            refreshSecretView();
         }
         else
         {
            refreshView();
         }
      }
   }
}

