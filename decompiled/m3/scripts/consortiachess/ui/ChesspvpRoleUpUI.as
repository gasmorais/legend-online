package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.item.ChesspvpRoleUpItem;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import utils.LogicUtils;
   
   public class ChesspvpRoleUpUI extends Sprite
   {
      
      protected var _roleUpbg:Bitmap;
      
      protected var _roleUpBtn:IconButton;
      
      protected var _roleUpTitle:FilterFrameText;
      
      protected var _roleUpHbox:HBox;
      
      private var _itemList:Array = [];
      
      private var _chooseBit:Bitmap;
      
      private var _chooseItem:ChesspvpRoleUpItem;
      
      public var callFun:Function;
      
      public function ChesspvpRoleUpUI()
      {
         super();
         initView();
         initData();
         initEvent();
         var _loc1_:ChesspvpRoleUpItem = _itemList[0];
         _loc1_.dispatchEvent(new MouseEvent("click"));
      }
      
      protected function initView() : void
      {
         _roleUpbg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.roleUpbg");
         _roleUpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.roleUpBtn");
         _roleUpTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.roleUpTitle");
         _roleUpHbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.roleUpHbox");
         _chooseBit = new Bitmap();
         _chooseBit.bitmapData = ChesspvpResourceUtil.ins.chooseBit.bitmapData;
         addChild(_roleUpbg);
         addChild(_roleUpBtn);
         addChild(_roleUpTitle);
         addChild(_roleUpHbox);
         _roleUpTitle.text = LanguageMgr.GetTranslation("chesspvp.roleUp.tipTitle");
      }
      
      private function initData() : void
      {
         var _loc1_:ChesspvpRoleUpItem = null;
         var _loc3_:int = 0;
         var _loc4_:ChesspvpRoleInfo = ChessPvpManager.Instance.model.selfInfo;
         var _loc2_:Array = [5,4,3,2];
         _roleUpHbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new ChesspvpRoleUpItem(_loc2_[_loc3_],_loc4_.team);
            _roleUpHbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _roleUpHbox.commitChanges();
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:ChesspvpRoleUpItem in _itemList)
         {
            _loc1_.addEventListener("click",clickHandler);
         }
         _roleUpBtn.addEventListener("click",confrimBtnHandler);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:ChesspvpRoleUpItem in _itemList)
         {
            _loc1_.removeEventListener("click",clickHandler);
         }
         _roleUpBtn.addEventListener("click",confrimBtnHandler);
      }
      
      private function confrimBtnHandler(param1:MouseEvent) : void
      {
         if(_chooseItem == null)
         {
            return;
         }
         var _loc2_:ChessPvpBoardInfo = ChessPvpManager.Instance.model.boradInfo;
         var _loc3_:ChesspvpRoleInfo = ChessPvpManager.Instance.model.selfInfo;
         ChessPvpManager.Instance.operChess(ChessPvpOp.BOARD_OP_ROLE_CHANGE,_loc2_.boardUid,_loc3_.userID,_loc3_.servername,-1,_chooseItem.type);
         if(callFun != null)
         {
            callFun();
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChesspvpRoleUpItem = param1.currentTarget as ChesspvpRoleUpItem;
         if(_loc2_)
         {
            if(_chooseItem != _loc2_)
            {
               _chooseItem = _loc2_;
               _loc2_.addChild(_chooseBit);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_roleUpbg);
         _roleUpbg = null;
         ObjectUtils.disposeObject(_roleUpBtn);
         _roleUpBtn = null;
         ObjectUtils.disposeObject(_roleUpTitle);
         _roleUpTitle = null;
         ObjectUtils.disposeObject(_roleUpHbox);
         _roleUpHbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _chooseItem = null;
      }
   }
}

