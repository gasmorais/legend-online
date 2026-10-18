package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseItemView;
   
   public class ChristmasGiftItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      private var _icon:MutipleImage;
      
      private var _numContiner:ScaleFrameImage;
      
      private var _hBox:HBox;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _getFlg:Bitmap;
      
      private var _pointBg:Bitmap;
      
      private var _pointBit:TextAddBitmap;
      
      private var _itemList:Array;
      
      private var _data:ChristmasActivitiesTempInfo;
      
      private var _index:int;
      
      public function ChristmasGiftItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.ChristmasGiftItem.bg");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("christmasGiftItem.desTxt");
         _icon = ComponentFactory.Instance.creatComponentByStylename("ui.christmasGiftItem.iconBg");
         _numContiner = ComponentFactory.Instance.creatComponentByStylename("christmasGiftItem.numtxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("christmasGiftItem.hBox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("christmasGiftItem.giftBtn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("christmasGiftItem.giftBtnTxt");
         _getFlg = ComponentFactory.Instance.creatBitmap("asset.ChristmasGiftItem.buyFlg");
         _pointBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasGiftItem.giftptBg");
         _pointBit = ComponentFactory.Instance.creatCustomObject("christmasGiftItem.giftPtBit");
         _pointBit.initView("christmasGiftItem.pointNumTx","asset.core.SmallPointImg");
         addChild(_bg);
         addChild(_desTxt);
         addChild(_icon);
         addChild(_hBox);
         addChild(_btn);
         addChild(_pointBg);
         addChild(_pointBit);
         addChild(_getFlg);
         addChild(_numContiner);
         _numContiner.setFrame(_index);
         _btn.addChild(_btnIcon);
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_data)
         {
            if(_data.SonType == 1)
            {
               sendBuy();
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
               if(_data.Para2 > _loc5_)
               {
                  RechargeAlertMannager.show();
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
                  _loc3_ = LanguageMgr.GetTranslation("Christmasitem.gift.num" + _index);
                  _loc4_ = LanguageMgr.GetTranslation("Christmasitem.gift.buy",_data.Para2,_loc3_);
                  SharedManagerHelper.ins.needAlert("ChristmasGiftBox_clickHandler",sendBuy,_loc2_,_loc4_);
               }
            }
         }
      }
      
      private function sendBuy() : void
      {
         ChristmasManager.instance.opRequest(3,_data.Id);
      }
      
      public function set data(param1:ChristmasActivitiesTempInfo) : void
      {
         _data = param1;
         if(_data)
         {
            if(_data.SonType == 1)
            {
               _pointBit.visible = false;
               _pointBg.visible = false;
            }
            else
            {
               _pointBit.visible = true;
               _pointBg.visible = true;
               _pointBit.setText("" + _data.Para2);
            }
            _itemList = [];
            refreshView();
            _hBox.beginChanges();
            createGoodItem(_data.Reward1,_data.Num1);
            createGoodItem(_data.Reward2,_data.Num2);
            createGoodItem(_data.Reward3,_data.Num3);
            createGoodItem(_data.Reward4,_data.Num4);
            _hBox.commitChanges();
            _hBox.x = 30 + 33 * (4 - _hBox.numChildren);
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
         _hBox.addChild(_loc3_);
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
         if(_data)
         {
            _loc10_ = "" + _data.Id;
            _loc9_ = int(_data.Limit);
            _loc7_ = int(_loc2_[_loc10_]);
            _loc3_ = _loc9_ - _loc7_;
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            if(_data.SonType == 1)
            {
               _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.free",_loc3_,_loc9_);
            }
            else if(_data.SonType == 2)
            {
               _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.noCondition",_loc3_,_loc9_);
            }
            else
            {
               _desTxt.htmlText = LanguageMgr.GetTranslation("carnival.gift.needPoint",_data.Para1,_loc3_,_loc9_);
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
               if(_data.Para1 <= model.dayCharge)
               {
                  _btn.enable = true;
                  if(_data.SonType == 1)
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
                  _btn.enable = false;
                  _btnIcon.setFrame(3);
               }
            }
         }
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_numContiner);
         _numContiner = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
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
         _data = null;
         _itemList = null;
      }
   }
}

