package funny.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import yishi.manager.PlayerManager;
   
   public class TiroFunnyButton extends SelectedIconButton
   {
      
      private var _state:int;
      
      private var _type:int;
      
      private var _icon:Bitmap;
      
      private var _getRewardImg:Bitmap;
      
      private var _timeOverImg:Bitmap;
      
      private var _data:FunnyData;
      
      private var _iconPosX:Object;
      
      private var _iconPosY:Object;
      
      private var _selectedState:Boolean;
      
      public function TiroFunnyButton()
      {
         super();
         _iconPosX = {
            "38":40,
            "41":22,
            "6":41,
            "25":31,
            "36":30,
            "37":46,
            "19":36,
            "42":23,
            "11":33,
            "39":38,
            "45":52
         };
         _iconPosY = {
            "38":13,
            "41":12,
            "6":7,
            "25":7,
            "36":12,
            "37":12,
            "19":12,
            "42":7,
            "11":7,
            "39":6,
            "45":7
         };
         initView();
      }
      
      private function initView() : void
      {
      }
      
      public function set data(param1:FunnyData) : void
      {
         var _loc2_:FunnyBagData = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _icon = ComponentFactory.Instance.creatBitmap("asset.funny.tiroBtnTitle" + _data.type);
         _getRewardImg = ComponentFactory.Instance.creatBitmap("asset.funny.leftIcon");
         _timeOverImg = ComponentFactory.Instance.creatBitmap("asset.funny.timeOverIcon");
         addChild(_icon);
         addChild(_getRewardImg);
         addChild(_timeOverImg);
         _timeOverImg.visible = false;
         var _loc3_:int = int(data.bagList.length);
         var _loc4_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = data.bagList[_loc6_] as FunnyBagData;
            if(_loc2_.status == 1)
            {
               _loc4_ = true;
               break;
            }
            _loc6_++;
         }
         if(_loc4_)
         {
            _getRewardImg.visible = true;
         }
         else
         {
            _getRewardImg.visible = false;
         }
         _icon.x = _iconPosX[_data.type + ""];
         _icon.y = _iconPosY[_data.type + ""];
         var _loc5_:Date = new Date(_data.endTime);
         if(_loc5_ <= PlayerManager.instance.currentPlayerModel.sysCurtime)
         {
            _timeOverImg.visible = true;
            _getRewardImg.visible = false;
         }
      }
      
      public function get data() : FunnyData
      {
         return _data;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function set setSelectedState(param1:Boolean) : void
      {
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_getRewardImg);
      }
   }
}

