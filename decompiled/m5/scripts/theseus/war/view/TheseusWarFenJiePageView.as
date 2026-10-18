package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusFJItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseItemView;
   
   public class TheseusWarFenJiePageView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _title1:Bitmap;
      
      private var _title2:Bitmap;
      
      private var _fjBtn:IconButton;
      
      private var _row:MovieClip;
      
      private var _itemList:Array = [];
      
      private var _itemPanel:SimpleTileList;
      
      private var _goldTxt:TextAddBitmap;
      
      private var _goodItemBox:HBox;
      
      private var _poolDic:SimpleDictionary = new SimpleDictionary();
      
      private var _sendIdList:Array = [];
      
      private var _rewardsPanel:ScrollPanel;
      
      public function TheseusWarFenJiePageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusFJItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.fjBg");
         _title1 = ComponentFactory.Instance.creatBitmap("asset.theseus.resolvePromptTxtBg");
         _title2 = ComponentFactory.Instance.creatBitmap("asset.theseus.resolvePreviewTxtBg");
         _fjBtn = ComponentFactory.Instance.creatComponentByStylename("theseuswar.resolve.resolveBtn");
         _row = ComponentFactory.Instance.creatCustomObject("ui.theseus.fenjie1Row");
         _itemPanel = ComponentFactory.Instance.creatCustomObject("theseus.fenjie.fromList",[6]);
         _goodItemBox = ComponentFactory.Instance.creatComponentByStylename("theseus.fenjie.rewardHbox");
         _goldTxt = new TextAddBitmap();
         _rewardsPanel = ComponentFactory.Instance.creatComponentByStylename("theseus.fenjie.panel");
         addChild(_bg);
         addChild(_title1);
         addChild(_title2);
         addChild(_row);
         addChild(_itemPanel);
         addChild(_rewardsPanel);
         _rewardsPanel.setView(_goodItemBox);
         addChild(_goldTxt);
         addChild(_fjBtn);
         _fjBtn.enable = false;
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 6;
         _itemPanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseus.war.fj.resolveEquiItem");
            _itemList[_loc2_] = _loc1_;
            _itemPanel.addChild(_loc1_);
            _loc2_++;
         }
         _itemPanel.commitChanges();
      }
      
      private function initEvent() : void
      {
         _fjBtn.addEventListener("click",fenjClickHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",fengjieResultHandler);
      }
      
      private function removeEvent() : void
      {
         _fjBtn.removeEventListener("click",fenjClickHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",fengjieResultHandler);
      }
      
      private function fengjieResultHandler(param1:Event) : void
      {
         _poolDic.clear();
         for each(var _loc2_:TheseusFJItem in _itemList)
         {
            _loc2_.data = null;
         }
         refreshRewardBox();
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            _poolDic.del(_loc2_);
            refreshRewardBox();
         }
      }
      
      private function refreshRewardBox() : void
      {
         var _loc16_:TheseusWarsoulItemInfo = null;
         var _loc3_:int = 0;
         var _loc14_:Array = null;
         var _loc8_:Array = null;
         var _loc4_:Array = null;
         var _loc12_:Array = null;
         var _loc9_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:BaseItemView = null;
         var _loc13_:GoodsInfo = null;
         _sendIdList.length = 0;
         var _loc1_:Array = _poolDic.getList();
         TheseussoulManager.Instance.warsoulModel.fenjieMax = _loc1_.length;
         var _loc11_:Dictionary = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc16_ = _loc1_[_loc5_];
            _sendIdList.push(_loc16_.id);
            _loc8_ = _loc16_.warTempInfo.Decompose.split("|");
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc4_ = _loc8_[_loc6_].split(",");
               _loc3_ = int(_loc4_[0]);
               if(_loc3_ != 0)
               {
                  if(_loc11_[_loc3_] == null)
                  {
                     _loc11_[_loc3_] = int(_loc4_[1]) * _loc16_.num;
                  }
                  else
                  {
                     var _loc17_:* = _loc3_;
                     var _loc18_:* = _loc11_[_loc17_] + int(_loc4_[1]) * _loc16_.num;
                     _loc11_[_loc17_] = _loc18_;
                  }
               }
               _loc6_++;
            }
            _loc14_ = _loc16_.warStrengthTempInfo.NeedItem.split(",");
            _loc3_ = int(_loc14_[0]);
            if(_loc3_ != 0)
            {
               if(_loc11_[_loc3_] == null)
               {
                  _loc11_[_loc3_] = _loc16_.warStrengthTempInfo.DecompositionReturn * _loc16_.num;
               }
               else
               {
                  _loc18_ = _loc3_;
                  _loc17_ = _loc11_[_loc18_] + _loc16_.warStrengthTempInfo.DecompositionReturn * _loc16_.num;
                  _loc11_[_loc18_] = _loc17_;
               }
            }
            if(!_loc16_.warStartempInfo)
            {
               return;
            }
            _loc12_ = _loc16_.warStartempInfo.Decompose.split("|");
            _loc7_ = 0;
            while(_loc7_ < _loc12_.length)
            {
               _loc9_ = _loc12_[_loc7_].split(",");
               _loc3_ = int(_loc9_[0]);
               if(_loc3_ != 0)
               {
                  if(_loc11_[_loc3_] == null)
                  {
                     _loc11_[_loc3_] = int(_loc9_[1]) * _loc16_.num;
                  }
                  else
                  {
                     _loc17_ = _loc3_;
                     _loc18_ = _loc11_[_loc17_] + int(_loc9_[1]) * _loc16_.num;
                     _loc11_[_loc17_] = _loc18_;
                  }
               }
               _loc7_++;
            }
            _loc5_++;
         }
         _fjBtn.enable = _loc1_.length > 0;
         _goodItemBox.beginChanges();
         _goodItemBox.removeAllChild();
         for(var _loc15_:String in _loc11_)
         {
            _loc10_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc13_ = new GoodsInfo();
            _loc13_.templateId = int(_loc15_);
            _loc13_.count = int(_loc11_[_loc15_]);
            _loc10_.data = _loc13_;
            _goodItemBox.addChild(_loc10_);
         }
         _goodItemBox.commitChanges();
         _rewardsPanel.invalidateViewport();
         if(_goodItemBox.numChildren <= 5)
         {
            _rewardsPanel.x = 180 - 27 * (_goodItemBox.numChildren - 1);
         }
         else
         {
            _rewardsPanel.x = 72;
         }
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc6_:TheseusWarsoulItemInfo = null;
         var _loc3_:TheseusFJItem = null;
         var _loc2_:TheseusFJItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(param1.data);
         if(_loc5_ > 0)
         {
            _loc6_ = TheseussoulManager.Instance.warsoulModel.getItemInfo(_loc5_);
            _loc4_ = 0;
            while(_loc4_ < 12)
            {
               _loc2_ = _itemList[_loc4_];
               if(_loc2_.data == null)
               {
                  _loc3_ = _loc2_;
                  break;
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               _loc3_.data = _loc6_;
               _poolDic.add(_loc6_.id,_loc6_);
               refreshRewardBox();
            }
         }
      }
      
      private function fenjClickHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doWarsoulParam(18,-1,0,-1,_sendIdList);
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusFJItem in _itemList)
         {
            if(_loc1_.data)
            {
               _loc1_.data.objectId = 0;
            }
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title1);
         _title1 = null;
         ObjectUtils.disposeObject(_title2);
         _title2 = null;
         ObjectUtils.disposeObject(_fjBtn);
         _fjBtn = null;
         ObjectUtils.disposeObject(_row);
         _row = null;
         ObjectUtils.disposeObject(_itemPanel);
         _itemPanel = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_goodItemBox);
         _goodItemBox = null;
         ObjectUtils.disposeObject(_rewardsPanel);
         _rewardsPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.fenjieMax = 0;
         NotificationManager.instance.sendNotification("Event.theseusWarReset");
      }
   }
}

