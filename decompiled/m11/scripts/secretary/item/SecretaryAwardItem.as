package secretary.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.MopupEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import mvc.module.mopup.MopupModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class SecretaryAwardItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _pre:FilterFrameText;
      
      private var _itemSprite:Sprite;
      
      private var _type:int;
      
      private var _data:Array;
      
      private var _goodsList:Array;
      
      private var goodsInfo:GoodsInfo;
      
      private var templateId:int;
      
      public function SecretaryAwardItem(param1:int)
      {
         _type = param1;
         super();
         _goodsList = [];
         initView();
         addEvent();
         _title.text = LanguageMgr.GetTranslation("secretary.awardtitle" + _type);
         _pre.text = "0%";
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.secrearytary.awardBg");
         addChild(_bg);
         _title = ComponentFactory.Instance.creatComponentByStylename("SecretaryAwardItem.titletext");
         _pre = ComponentFactory.Instance.creatComponentByStylename("SecretaryAwardItem.pretext");
         addChild(_title);
         addChild(_pre);
         _itemSprite = new Sprite();
         _pre.visible = false;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.addEventListener("MOPUP_END",__refreshENDView);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("MOPUP_RESULT_LIST_REFRESH",__refreshView);
         _model.removeEventListener("MOPUP_END",__refreshENDView);
      }
      
      private function get _model() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      public function __refreshENDView(param1:MopupEvent) : void
      {
         _pre.text = "100%";
      }
      
      public function __refreshView(param1:MopupEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         switch(_model.campaignId)
         {
            case 8001:
               _loc2_ = 2;
               break;
            case 8101:
               _loc2_ = 3;
               break;
            case 8401:
               _loc2_ = 4;
         }
         if(_type != _loc2_)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _model.resultInfoList.length)
         {
            if(_model.resultInfoList[_loc4_].items.length > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _model.resultInfoList[_loc4_].items.length)
               {
                  templateId = _model.resultInfoList[_loc4_].items[_loc5_].templateId;
                  goodsInfo = new GoodsInfo();
                  goodsInfo.templateId = templateId;
                  goodsInfo.count = _model.resultInfoList[_loc4_].items[_loc5_].count;
                  _goodsList.push(goodsInfo);
                  _loc5_++;
               }
            }
            _loc3_ = Math.floor(_model.resultInfoList[_model.resultInfoList.length - 1].cIndex / _model.resultInfoList[_model.resultInfoList.length - 1].eIndex * 100);
            if(_loc3_ != 0)
            {
               _pre.text = _loc3_ + "%";
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _goodsList.length)
         {
            _loc5_ = _loc4_ + 1;
            while(_loc5_ < _goodsList.length)
            {
               if(_goodsList[_loc4_].templateId == _goodsList[_loc5_].templateId)
               {
                  _goodsList[_loc4_].count += _goodsList[_loc5_].count;
                  _goodsList.splice(_loc5_,1);
                  _loc5_--;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         updateView(_goodsList);
      }
      
      public function updateView(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         ObjectUtils.disposeObject(_itemSprite);
         _itemSprite = null;
         _itemSprite = new Sprite();
         var _loc2_:Array = param1;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_[_loc4_].templateId;
            _loc5_.count = _loc2_[_loc4_].count;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
            _loc3_.x = _loc4_ % 4 * 60 + 10;
            _loc3_.y = Math.floor(_loc4_ / 4) * 60 + 35;
            _loc3_.data = _loc5_;
            _itemSprite.addChild(_loc3_);
            _loc4_++;
         }
         addChild(_itemSprite);
         if(!(_type == 2 || _type == 3 || _type == 4))
         {
            _pre.text = "100%";
         }
         _title.text = LanguageMgr.GetTranslation("secretary.awardtitle" + _type);
         _pre.visible = true;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

