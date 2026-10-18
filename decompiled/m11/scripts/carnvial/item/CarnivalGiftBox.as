package carnvial.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.manager.CarnivalManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalGiftBox extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _simpleTitle:SimpleTileList;
      
      private var _idxBit:ScaleFrameImage;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _getFlg:Bitmap;
      
      private var _itemList:Array;
      
      private var _tempInfo:CarnivalPointExchangeTemplateInfo;
      
      private var _pointBg:Bitmap;
      
      private var _pointBit:TextAddBitmap;
      
      private var _idx:int;
      
      private var _dic:Dictionary;
      
      public function CarnivalGiftBox(param1:int, param2:Dictionary)
      {
         super();
         _idx = param1;
         _dic = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.carniver.giftBoxBg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.giftBoxTargetTxt");
         _idxBit = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.giftIdx");
         _simpleTitle = ComponentFactory.Instance.creatCustomObject("ui.carnival.giftTList",[2]);
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.giftBtn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.giftBtnTxt");
         _getFlg = ComponentFactory.Instance.creatBitmap("asset.carniver.buyFlg");
         _pointBg = ComponentFactory.Instance.creatBitmap("asset.carniver.giftptBg");
         _pointBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.giftPtBit");
         _pointBit.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         addChild(_bg);
         addChild(_desTxt);
         addChild(_idxBit);
         addChild(_simpleTitle);
         addChild(_btn);
         addChild(_pointBg);
         addChild(_pointBit);
         addChild(_getFlg);
         _btn.addChild(_btnIcon);
         _idxBit.setFrame(_idx);
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
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(_tempInfo)
         {
            if(_tempInfo.Price > 0)
            {
               _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
               if(_tempInfo.Price > _loc4_)
               {
                  RechargeAlertMannager.show();
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
                  _loc3_ = LanguageMgr.GetTranslation("carnival.gift.buy",_tempInfo.Price,_tempInfo.Sort);
                  SharedManagerHelper.ins.needAlert("CarnivalGiftBox_clickHandler",sendBuy,_loc2_,_loc3_);
               }
            }
            else
            {
               sendBuy();
            }
         }
      }
      
      private function sendBuy() : void
      {
         CarnivalManager.Instance.opRequest(5,_tempInfo.Id);
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
         ObjectUtils.disposeObject(_simpleTitle);
         _simpleTitle = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnIcon);
         _btnIcon = null;
         ObjectUtils.disposeObject(_getFlg);
         _getFlg = null;
         ObjectUtils.disposeObject(_pointBg);
         _pointBg = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _dic = null;
      }
      
      public function set tempInfo(param1:CarnivalPointExchangeTemplateInfo) : void
      {
         _tempInfo = param1;
         if(_tempInfo)
         {
            if(_tempInfo.Target == 0)
            {
               if(_tempInfo.Price == 0)
               {
                  _pointBit.visible = false;
                  _pointBg.visible = false;
               }
               else
               {
                  _pointBit.visible = true;
                  _pointBg.visible = true;
                  _pointBit.setText("" + _tempInfo.Price);
               }
            }
            else
            {
               _pointBit.visible = true;
               _pointBg.visible = true;
               _pointBit.setText("" + _tempInfo.Price);
            }
            _itemList = [];
            refreshView();
            _simpleTitle.beginChanges();
            createGoodItem(_tempInfo.Item1,_tempInfo.ItemNum1);
            createGoodItem(_tempInfo.Item2,_tempInfo.ItemNum2);
            createGoodItem(_tempInfo.Item3,_tempInfo.ItemNum3);
            createGoodItem(_tempInfo.Item4,_tempInfo.ItemNum4);
            _simpleTitle.commitChanges();
         }
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      public function refreshView() : void
      {
         var _loc8_:* = null;
         var _loc5_:Array = null;
         var _loc10_:String = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:String = model.giftBuyInfo;
         var _loc4_:Array = _loc6_.split("|");
         var _loc2_:Dictionary = new Dictionary();
         for each(var _loc1_:String in _loc4_)
         {
            _loc5_ = _loc1_.split(",");
            _loc2_[_loc5_[0]] = int(_loc5_[1]);
         }
         if(_tempInfo)
         {
            _loc10_ = "" + _tempInfo.Id;
            _loc9_ = int(_dic[_loc10_]);
            _loc7_ = int(_loc2_[_loc10_]);
            _loc3_ = _loc9_ - _loc7_;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_tempInfo.Target == 0)
            {
               if(_tempInfo.Price == 0)
               {
                  _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.free",_loc3_,_loc9_);
               }
               else
               {
                  _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.noCondition",_loc3_,_loc9_);
               }
            }
            else
            {
               _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.needPoint",_tempInfo.Target,_loc3_,_loc9_);
            }
            if(_loc2_[_loc10_] != null && _loc2_[_loc10_] == _loc9_)
            {
               _getFlg.visible = true;
               _btn.visible = false;
            }
            else
            {
               _getFlg.visible = false;
               _btn.visible = true;
               if(_tempInfo.Target <= model.dayCharge)
               {
                  _btn.enable = true;
                  if(_tempInfo.Target == 0)
                  {
                     if(_tempInfo.Price == 0)
                     {
                        _btnIcon.setFrame(1);
                     }
                     else
                     {
                        _btnIcon.setFrame(2);
                     }
                  }
                  else
                  {
                     _btnIcon.setFrame(2);
                  }
               }
               else
               {
                  _btn.enable = false;
                  _btnIcon.setFrame(3);
               }
            }
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

