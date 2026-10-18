package carnvial.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalOnLineBox extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _getFlg:Image;
      
      private var _itemList:Array = [];
      
      private var _tempInfo:CarnivalPointExchangeTemplateInfo;
      
      public function CarnivalOnLineBox()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.carniver.onLineBoxBg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineTimeTxt");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.carnival.onLineHbox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineGetBtn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineBtnTxt");
         _getFlg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.OnLinehasGet");
         addChild(_bg);
         addChild(_desTxt);
         addChild(_hbox);
         addChild(_btn);
         addChild(_getFlg);
         _btn.addChild(_btnIcon);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_tempInfo)
         {
            CarnivalManager.Instance.opRequest(8,_tempInfo.Id);
         }
      }
      
      public function refreshView(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = model.onlineRewardInfo;
         var _loc2_:Array = _loc3_.split(",");
         if(_tempInfo)
         {
            _loc4_ = "" + _tempInfo.Id;
            if(_loc2_.indexOf(_loc4_) != -1)
            {
               _getFlg.visible = true;
               _btn.visible = false;
            }
            else
            {
               _getFlg.visible = false;
               _btn.visible = true;
               if(_tempInfo.Target <= param1)
               {
                  _btn.enable = true;
                  _btnIcon.setFrame(1);
               }
               else
               {
                  _btn.enable = false;
                  _btnIcon.setFrame(2);
               }
            }
         }
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnIcon);
         _btnIcon = null;
         ObjectUtils.disposeObject(_getFlg);
         _getFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set tempInfo(param1:CarnivalPointExchangeTemplateInfo) : void
      {
         _tempInfo = param1;
         if(_tempInfo)
         {
            _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.onLineTarget",_tempInfo.Target);
            _hbox.beginChanges();
            createGoodItem(_tempInfo.Item1,_tempInfo.ItemNum1);
            createGoodItem(_tempInfo.Item2,_tempInfo.ItemNum2);
            createGoodItem(_tempInfo.Item3,_tempInfo.ItemNum3);
            _hbox.commitChanges();
         }
      }
      
      private function createGoodItem(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = param1;
         _loc4_.count = param2;
         _loc3_.data = _loc4_;
         _itemList.push(_loc3_);
         _hbox.addChild(_loc3_);
      }
   }
}

