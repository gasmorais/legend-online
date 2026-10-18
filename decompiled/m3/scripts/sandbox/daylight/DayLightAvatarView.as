package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import sandbox.daylight.data.DayLightUnitInfo;
   
   public class DayLightAvatarView extends Component implements Disposeable
   {
      
      private var _avatar:ScaleFrameImage;
      
      private var _infoBg:Image;
      
      private var _infoTxt:FilterFrameText;
      
      private var _testTxt:FilterFrameText;
      
      private var _speedX:Number;
      
      private var _targetX:Number;
      
      private var _positionX:Number;
      
      private var _velocityX:Number;
      
      private var _team:int;
      
      private var _targetDiff:int;
      
      private var _data:DayLightUnitInfo;
      
      public function DayLightAvatarView(param1:int)
      {
         _team = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _avatar = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightAvatarView.avatar");
         _infoBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightAvatarView.infoBg");
         _infoTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightAvatarView.infoTxt");
         _testTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightAvatarView.infoTxt");
         _avatar.setFrame(1);
         _infoTxt.text = "X99";
         _testTxt.text = "0";
         _testTxt.y = -35;
         addChild(_avatar);
         addChild(_infoBg);
         addChild(_infoTxt);
      }
      
      private function uninitView() : void
      {
         if(_avatar)
         {
            ObjectUtils.disposeObject(_avatar);
         }
         _avatar = null;
         if(_infoBg)
         {
            ObjectUtils.disposeObject(_infoBg);
         }
         _infoBg = null;
         if(_infoTxt)
         {
            ObjectUtils.disposeObject(_infoTxt);
         }
         _infoTxt = null;
         if(_testTxt)
         {
            ObjectUtils.disposeObject(_testTxt);
         }
         _testTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : DayLightUnitInfo
      {
         return _data;
      }
      
      public function set data(param1:DayLightUnitInfo) : void
      {
         _data = param1;
      }
      
      private function updateInfoView() : void
      {
         if(data)
         {
            if(data.type == 0)
            {
               _avatar.setFrame(_team);
               _infoTxt.text = "X1";
               _targetDiff = 1 * data.speed;
            }
            else
            {
               _avatar.setFrame(data.type + 2);
               _infoTxt.text = "X" + data.count;
               _targetDiff = -1 * data.speed;
            }
            _targetDiff = 0;
            _testTxt.text = data.x.toString();
         }
      }
      
      public function initUnitInfo() : void
      {
         if(data)
         {
            updateInfoView();
            _speedX = data.speed * 36;
            _targetX = (data.x + _targetDiff) * 36;
            _positionX = data.x * 36;
            _velocityX = 0;
         }
      }
      
      public function updateUnitInfo() : void
      {
         if(data)
         {
            updateInfoView();
            _targetX = (data.x + _targetDiff) * 36;
         }
      }
      
      public function updateUnitPosition() : void
      {
         if(data)
         {
            x = data.x * 36;
            y = data.y * 48;
         }
      }
      
      public function update(param1:Number) : void
      {
         speedBehavior();
         _positionX += _velocityX * param1 / 1000;
         boundBehavior();
         x = _positionX;
      }
      
      public function speedBehavior() : void
      {
         if(_positionX < _targetX)
         {
            _velocityX = _speedX;
         }
         else if(_positionX > _targetX)
         {
            _velocityX = -_speedX;
         }
         else
         {
            _velocityX = 0;
         }
      }
      
      public function boundBehavior() : void
      {
         if(_velocityX < 0)
         {
            if(_positionX < _targetX)
            {
               _positionX = _targetX;
            }
         }
         if(_velocityX > 0)
         {
            if(_positionX > _targetX)
            {
               _positionX = _targetX;
            }
         }
         if(_positionX < 0)
         {
            _positionX = 0;
         }
         if(_positionX > 504)
         {
            _positionX = 504;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

