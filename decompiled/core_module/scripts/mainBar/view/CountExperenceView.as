package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   
   public class CountExperenceView extends Component
   {
      
      private var _countValue:FilterFrameText;
      
      private var _countProgress:Bitmap;
      
      private var _countProgressBg:Bitmap;
      
      private var _countAlertMc:MovieClip;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:UserArmy;
      
      private var _percent:Number;
      
      public function CountExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _countValue = ComponentFactory.Instance.creatComponentByStylename("resourceBar.CountValueTxt");
         _countValue.text = "1200 / 1200";
         _countProgress = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PawnProgress");
         _countAlertMc = ComponentFactory.Instance.creatCustomObject("resourcesBar.CountAlertMc");
         addChild(_countProgress);
         addChild(_countValue);
         _mask = createShape();
         addChild(_mask);
         _countProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(0,0,_countProgress.width,_countProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _countProgress.width * -1 + _countProgress.x;
         return _loc1_;
      }
      
      private function setCountAlertMcVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(!_countAlertMc.parent && ArmyManager.instance.thane.grades >= 6)
            {
               addChildAt(_countAlertMc,0);
               _countAlertMc.gotoAndPlay(1);
            }
         }
         else if(_countAlertMc.parent)
         {
            _countAlertMc.gotoAndStop(1);
            removeChild(_countAlertMc);
         }
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _countValue.text = _data.countAllArmyPawnNmber() + " / " + _data.baseHero.attackProrerty.totalConatArmy;
            _percent = _data.countAllArmyPawnNmber() / _data.baseHero.attackProrerty.totalConatArmy;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
            _percent < 0.1 ? setCountAlertMcVisible(true) : setCountAlertMcVisible(false);
         }
         else
         {
            _countValue.text = "0 / 0";
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
            setCountAlertMcVisible(true);
         }
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

