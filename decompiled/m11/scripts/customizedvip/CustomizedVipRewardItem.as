package customizedvip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.CustomizedVipManager;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipItemInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class CustomizedVipRewardItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _selectCon:Component;
      
      private var _rewardBg:Bitmap;
      
      private var _addImage:Bitmap;
      
      private var _goodsItem:BaseItemView;
      
      private var _selectImage:Bitmap;
      
      private var type:int;
      
      private var index:int;
      
      private var _boxInfo:CustomizedVipBoxInfo;
      
      private var _data:CustomizedVipItemInfo;
      
      public function CustomizedVipRewardItem(param1:int, param2:int)
      {
         super();
         type = param1;
         index = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRewardItem.bg");
         _selectCon = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipRewardItem.selectCon");
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRewardItem.rewardBg");
         _addImage = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRewardItem.addImage");
         _goodsItem = ComponentFactory.Instance.creatCustomObject("CustomizedVipRewardItem.goodsItem");
         _selectImage = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRewardItem.selectImage");
         if(type == 3)
         {
            addChild(_selectCon);
            addChild(_selectImage);
            _selectImage.visible = false;
            _selectCon.addChild(_goodsItem);
            _goodsItem.icon.iconHeight = _goodsItem.icon.iconWidth = 48;
            _goodsItem.x = _goodsItem.y = 8;
            _goodsItem.itemText.x = 4;
            _goodsItem.itemText.y = 29;
         }
         else
         {
            addChild(_bg);
            addChild(_selectCon);
            _selectCon.addChild(_addImage);
            _selectCon.addChild(_goodsItem);
            _selectCon.addChild(_rewardBg);
            _goodsItem.icon.iconHeight = _goodsItem.icon.iconWidth = 60;
            _goodsItem.x = _goodsItem.y = 2;
            _goodsItem.itemText.x = 14;
            _goodsItem.itemText.y = 39;
         }
         _selectCon.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         _selectCon.addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectCon)
         {
            _selectCon.removeEventListener("click",__itemClickHandler);
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("REWARD_ITEM_SELECT",{
            "type":type,
            "index":index,
            "boxInfo":boxInfo,
            "data":data
         });
      }
      
      public function get boxInfo() : CustomizedVipBoxInfo
      {
         return _boxInfo;
      }
      
      public function set boxInfo(param1:CustomizedVipBoxInfo) : void
      {
         _boxInfo = param1;
      }
      
      public function get data() : CustomizedVipItemInfo
      {
         return _data;
      }
      
      public function set data(param1:CustomizedVipItemInfo) : void
      {
         var _loc2_:GoodsInfo = null;
         _data = param1;
         if(!data || !boxInfo)
         {
            _goodsItem.data = null;
         }
         else
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = data.tempId;
            _loc2_.count = data.count;
            _goodsItem.data = _loc2_;
            if(model.frameSelectDic[boxInfo.type] && model.frameSelectDic[boxInfo.type][data.area] && model.frameSelectDic[boxInfo.type][data.area].tempId == data.tempId)
            {
               _selectImage.visible = true;
            }
            else
            {
               _selectImage.visible = false;
            }
         }
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selectCon);
         _selectCon = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_addImage);
         _addImage = null;
         ObjectUtils.disposeObject(_goodsItem);
         _goodsItem = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         super.dispose();
      }
   }
}

