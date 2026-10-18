package loginactivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import managers.FunnyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   import yishi.view.component.TileContainer;
   
   public class LoginContinueItem extends Component
   {
      
      private var _countImage:Bitmap;
      
      private var _border:ScaleBitmapImage;
      
      private var _dayText:FilterFrameText;
      
      private var _itemContiner:TileContainer;
      
      private var _getBtn:IconButton;
      
      private var _data:FunnyBagData;
      
      public function LoginContinueItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _countImage = ComponentFactory.Instance.creatBitmap("asset.LoginContinueItem.countImage");
         _dayText = ComponentFactory.Instance.creatComponentByStylename("LoginContinueItem.dayText");
         _border = ComponentFactory.Instance.creatComponentByStylename("LoginContinueItem.border");
         _itemContiner = ComponentFactory.Instance.creatCustomObject("LoginContinueItem.itemContiner");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("LoginContinueItem.getBtn");
         addChild(_countImage);
         addChild(_dayText);
         addChild(_border);
         addChild(_itemContiner);
         addChild(_getBtn);
      }
      
      private function addEvent() : void
      {
         _getBtn.addEventListener("click",__getBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getBtnClickHandler);
         }
      }
      
      private function __getBtnClickHandler(param1:MouseEvent) : void
      {
         FunnyManager.instance.sendGetBag(2,_data.activeId,_data.id);
         param1.stopPropagation();
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         _itemContiner.removeAllChildren();
         _loc3_ = 0;
         while(_loc3_ < _data.rewardList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("LoginContinueItem.rewardItem");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _data.rewardList[_loc3_].temId;
            _loc4_.count = _data.rewardList[_loc3_].count;
            _loc4_.isBinds = _data.rewardList[_loc3_].isBind;
            _loc4_.strengthenGrade = _data.rewardList[_loc3_].strengthenGrade;
            _loc2_.data = _loc4_;
            _itemContiner.appendItem(_loc2_);
            _loc3_++;
         }
         if(_data.status == 1)
         {
            _getBtn.enable = true;
            _getBtn.iconStyle = "asset.LoginContinueItem.getBtnIcon";
            _getBtn.iconInnerRectString = "37,43,9,22,13";
         }
         else if(_data.status == 2)
         {
            _getBtn.enable = false;
            _getBtn.iconStyle = "asset.LoginContinueItem.hasGetBtnIcon";
            _getBtn.iconInnerRectString = "28,62,10,22,13";
         }
         else if(_data.status == 3)
         {
            _getBtn.enable = false;
            _getBtn.iconStyle = "asset.LoginContinueItem.getBtnIcon";
            _getBtn.iconInnerRectString = "37,43,9,22,13";
         }
         _dayText.text = _data.conditionList[0].value + "";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_countImage);
         _countImage = null;
         ObjectUtils.disposeObject(_dayText);
         _dayText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_itemContiner);
         _itemContiner = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         super.dispose();
      }
   }
}

