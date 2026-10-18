package map.campaign.view.fall
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignSocketOutManager;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.view.physics.PhysicsChestView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class BattleFallGoodsView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _font:Bitmap;
      
      private var _itemList:Vector.<BattleFallGoodsItem>;
      
      private var _list:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _closeBtn:BaseButton;
      
      private var _reciveBtn:BaseButton;
      
      public var signId:String;
      
      public var posX:int;
      
      public var posY:int;
      
      public var nodeInfo:MapPhysics;
      
      private var _backCall:Function;
      
      private var _arrayData:Array;
      
      public function BattleFallGoodsView(param1:Function)
      {
         _backCall = param1;
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.campaign.battleFallGoodsBG");
         _list = ComponentFactory.Instance.creatCustomObject("core.fallGoods.simpleTitleList",[1]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("campaign.BattleFallGoods.ScrollPanel");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.BattleFallGoods.CloseBtn");
         _reciveBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.FallGoodsCommitBtn");
         _panel.setView(_list);
         _panel.invalidateViewport();
         addChild(_bg);
         addChild(_panel);
         addChild(_closeBtn);
         addChild(_reciveBtn);
         _itemList = new Vector.<BattleFallGoodsItem>();
      }
      
      private function initEvents() : void
      {
         _closeBtn.addEventListener("click",_closeHandler);
         _reciveBtn.addEventListener("click",_reciveClick);
         this.addEventListener("focusOut",__focusOut);
         addEventListener("keyDown",__onKeyDown);
         StageReferance.stage.focus = this;
         NotificationManager.instance.addEventListener("OPEN_CHEST_BOX",__openNewBoxHandler);
      }
      
      private function removeEvents() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",_closeHandler);
         }
         if(_reciveBtn)
         {
            _reciveBtn.removeEventListener("click",_reciveClick);
         }
         this.removeEventListener("focusOut",__focusOut);
         removeEventListener("keyDown",__onKeyDown);
         NotificationManager.instance.removeEventListener("OPEN_CHEST_BOX",__openNewBoxHandler);
      }
      
      private function __focusOut(param1:FocusEvent) : void
      {
         StageReferance.stage.focus = this;
      }
      
      private function __openNewBoxHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function _closeHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function _reciveClick(param1:MouseEvent) : void
      {
         sendGetFallChest();
         disposeNode();
         dispose();
      }
      
      private function sendGetFallChest() : void
      {
         CampaignSocketOutManager.instance.getFallChest(signId,0,0);
      }
      
      private function disposeNode() : void
      {
         nodeInfo.info.state = 8;
         nodeInfo.commit();
         nodeInfo = null;
      }
      
      protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,this))
         {
            if(param1.keyCode == 27)
            {
               dispose();
               param1.stopImmediatePropagation();
            }
         }
      }
      
      public function set arrayData(param1:Array) : void
      {
         var _loc2_:int = 0;
         _clear();
         initCell(param1.length);
         _arrayData = param1;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _itemList[_loc2_].data = param1[_loc2_];
            _itemList[_loc2_].addEventListener("click",__onClickHandler);
            _itemList[_loc2_].buttonMode = true;
            _loc2_++;
         }
      }
      
      private function initCell(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BattleFallGoodsItem = null;
         param1 = int(param1 > 4 ? param1 : 4);
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = new BattleFallGoodsItem();
            _itemList.push(_loc2_);
            _list.addChild(_loc2_);
            _loc3_++;
         }
         if(param1 <= 4)
         {
            _panel.x = 7;
         }
         else
         {
            _panel.x = 12;
         }
         _list.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function _clear() : void
      {
         if(_itemList)
         {
            for each(var _loc1_:BattleFallGoodsItem in _itemList)
            {
               if(_loc1_)
               {
                  _loc1_.removeEventListener("click",__onClickHandler);
               }
               ObjectUtils.disposeObject(_loc1_);
            }
            _itemList.splice(0,_itemList.length);
         }
         if(_panel)
         {
            _panel.invalidateViewport();
         }
      }
      
      private function bagIsFull() : Boolean
      {
         var _loc1_:int = int(GoodsManager.instance.findNullCount());
         return _loc1_ == 0;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BattleFallGoodsItem = param1.currentTarget as BattleFallGoodsItem;
         if(_loc2_ && _loc2_.data)
         {
            pickUpGoods(_loc2_.data);
         }
      }
      
      private function pickUpGoods(param1:GoodsInfo) : Boolean
      {
         var _loc2_:String = null;
         if(canPickup(param1))
         {
            sendGetSimpleGoods(param1.templateId);
            if(_arrayData && _arrayData.length > 0)
            {
               arrayData = _arrayData;
            }
            return true;
         }
         _loc2_ = LanguageMgr.GetTranslation("map.campaign.view.fall.command01");
         MessageTipManager.instance().show(_loc2_);
         return false;
      }
      
      private function canPickup(param1:GoodsInfo) : Boolean
      {
         var _loc3_:int = 0;
         if(GoodsCheck.isGoldInCampaign(param1))
         {
            return true;
         }
         var _loc4_:int = int(param1.templateInfo.MaxCount);
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempId(param1.templateId));
         if(_loc2_ % _loc4_ == 0)
         {
            _loc3_ = int(GoodsManager.instance.findNullCount());
            return _loc3_ != 0;
         }
         return true;
      }
      
      private function sendGetSimpleGoods(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:PhysicsChestView = null;
         CampaignSocketOutManager.instance.getFallChest(signId,param1,0);
         _loc3_ = 0;
         while(_loc3_ < _arrayData.length)
         {
            _loc4_ = _arrayData[_loc3_] as GoodsInfo;
            if(_loc4_ && _loc4_.templateId == param1)
            {
               _arrayData.splice(_loc3_,1);
            }
            _loc3_++;
         }
         if(nodeInfo as CampaignNode)
         {
            (nodeInfo as CampaignNode).tempData = _arrayData;
            _loc2_ = (nodeInfo as CampaignNode).nodeView as PhysicsChestView;
            if(_loc2_)
            {
               _loc2_.goods = _arrayData;
            }
         }
         if(_arrayData.length == 0)
         {
            nodeInfo.info.state = 8;
            nodeInfo.commit();
            nodeInfo = null;
            dispose();
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc1_:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(_loc1_ && contains(_loc1_))
         {
            StageReferance.stage.focus = null;
         }
         _clear();
         _itemList = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_font)
         {
            ObjectUtils.disposeObject(_font);
         }
         _font = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_reciveBtn)
         {
            _reciveBtn.dispose();
         }
         _reciveBtn = null;
         if(_backCall != null)
         {
            _backCall();
         }
         _backCall = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(nodeInfo && nodeInfo.info.state == 9)
         {
            nodeInfo.info.state = 1;
            nodeInfo.commit();
         }
         _arrayData = null;
      }
   }
}

