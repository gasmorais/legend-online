package store.resolve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.AvengerManager;
   import yishi.utils.MsgMan;
   
   public class AvengerResolveItem extends Component
   {
      
      private var _itemBack:ScaleBitmapImage;
      
      private var _propImage:Image;
      
      private var _propItem:AvengerStoreItemCell;
      
      private var _reduceBtn:BaseButton;
      
      private var _numBack:Bitmap;
      
      private var _numText:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _data:GoodsInfo;
      
      private var resolveCount:int = 0;
      
      private var maxCount:int = 0;
      
      public function AvengerResolveItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("store.resolveBack");
         _propImage = ComponentFactory.Instance.creatComponentByStylename("store.resolveEquipBg");
         _propItem = ComponentFactory.Instance.creatCustomObject("AvengerResolveItem.propItem",[3]);
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerResolveItem.reduceBtn");
         _numBack = ComponentFactory.Instance.creatBitmap("asset.AvengerResolveItem.numBack");
         _numText = ComponentFactory.Instance.creatComponentByStylename("AvengerResolveItem.numText");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerResolveItem.addBtn");
         addChild(_itemBack);
         addChild(_propImage);
         addChild(_propItem);
         addChild(_reduceBtn);
         addChild(_numBack);
         addChild(_numText);
         addChild(_addBtn);
         _numText.text = "0";
         _reduceBtn.enable = false;
         _addBtn.enable = false;
         this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _reduceBtn.addEventListener("click",__reduceClickHandler);
         _addBtn.addEventListener("click",__addClickHandler);
         _numText.addEventListener("change",__numTextChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_reduceBtn)
         {
            _reduceBtn.removeEventListener("click",__reduceClickHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addClickHandler);
         }
         if(_numText)
         {
            _numText.removeEventListener("change",__numTextChangeHandler);
         }
      }
      
      private function __reduceClickHandler(param1:MouseEvent) : void
      {
         if(resolveCount <= 1)
         {
            return;
         }
         resolveCount = resolveCount - 1;
         refreshCount();
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         if(resolveCount >= maxCount)
         {
            return;
         }
         resolveCount = resolveCount + 1;
         refreshCount();
      }
      
      private function __numTextChangeHandler(param1:Event) : void
      {
         if(!data)
         {
            _numText.text = "0";
            return;
         }
         var _loc2_:int = parseInt(_numText.text);
         if(_loc2_ <= 0)
         {
            _numText.text = "1";
         }
         if(_loc2_ >= maxCount)
         {
            _numText.text = maxCount + "";
         }
         resolveCount = int(_numText.text);
         refreshCount();
      }
      
      private function refreshCount() : void
      {
         _numText.text = resolveCount + "";
         if(model.resolveBagDic[data.templateId])
         {
            (model.resolveBagDic[data.templateId] as GoodsInfo).count = resolveCount;
         }
         MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(data)
         {
            maxCount = model.armorBagDic[data.templateId].count;
            _propItem.data = data;
            resolveCount = data.count;
            _numText.text = data.count + "";
            _reduceBtn.enable = resolveCount > 1;
            _addBtn.enable = resolveCount < maxCount;
         }
         else
         {
            _propItem.data = null;
            _reduceBtn.enable = _addBtn.enable = false;
            _numText.text = "0";
         }
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_propImage);
         _propImage = null;
         ObjectUtils.disposeObject(_propItem);
         _propItem = null;
         ObjectUtils.disposeObject(_reduceBtn);
         _reduceBtn = null;
         ObjectUtils.disposeObject(_numBack);
         _numBack = null;
         ObjectUtils.disposeObject(_numText);
         _numText = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         super.dispose();
      }
   }
}

