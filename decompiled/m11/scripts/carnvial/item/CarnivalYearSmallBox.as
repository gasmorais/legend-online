package carnvial.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.view.base.NumberBitmap;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalYearSmallBox extends Sprite implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _pointBit:NumberBitmap;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _simpleTitle:SimpleTileList;
      
      private var _getFlg:Image;
      
      private var _itemList:Array;
      
      private var _temp:CarnivalPointExchangeTemplateInfo;
      
      public function CarnivalYearSmallBox()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,172,416);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.carniver.yearSmallBg");
         _simpleTitle = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearSList",[2]);
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearSbtn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineBtnTxt");
         _getFlg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearSget");
         _pointBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearTargetScoreBit");
         _pointBit.initParams("asset.carniver.score","asset.carniver.pointNum",18,22,15,18,"0123456789",-80,-2,0,80);
         addChild(_bg);
         addChild(_pointBit);
         addChild(_simpleTitle);
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
         if(_temp)
         {
            CarnivalManager.Instance.opRequest(2,_temp.Id);
         }
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
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnIcon);
         _btnIcon = null;
         ObjectUtils.disposeObject(_getFlg);
         _getFlg = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      public function refreshView() : void
      {
         var _loc3_:String = null;
         var _loc2_:String = model.scoreRewardInfo;
         var _loc1_:Array = _loc2_.split(",");
         if(_temp)
         {
            _loc3_ = "" + _temp.Id;
            if(_loc1_.indexOf(_loc3_) != -1)
            {
               _getFlg.visible = true;
               _btn.visible = false;
            }
            else
            {
               _getFlg.visible = false;
               _btn.visible = true;
               if(_temp.Target <= model.score)
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
      
      public function set temp(param1:CarnivalPointExchangeTemplateInfo) : void
      {
         _temp = param1;
         if(_temp)
         {
            _pointBit.num = _temp.Target;
            _itemList = [];
            refreshView();
            _simpleTitle.beginChanges();
            createGoodItem(_temp.Item1,_temp.ItemNum1);
            createGoodItem(_temp.Item2,_temp.ItemNum2);
            createGoodItem(_temp.Item3,_temp.ItemNum3);
            createGoodItem(_temp.Item4,_temp.ItemNum4);
            _simpleTitle.commitChanges();
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
         _simpleTitle.addChild(_loc3_);
      }
   }
}

