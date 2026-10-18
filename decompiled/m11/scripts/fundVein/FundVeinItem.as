package fundVein
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FundVeinManager;
   import mvc.module.fundVein.LevelInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   
   public class FundVeinItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _costImg:Bitmap;
      
      private var _getImg:Bitmap;
      
      private var _vBox:VBox;
      
      private var _itemCells:Vector.<FundVeinItemCell>;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _itemIcon:ScaleFrameImage;
      
      private var _joinBtn:IconButton;
      
      private var _diamondPoints:Array;
      
      private var _diamondCells:Vector.<FundVeinDiamondCell>;
      
      private var _index:int;
      
      private var _needPoint:int;
      
      private var _level:int;
      
      public function FundVeinItem(param1:int)
      {
         super();
         this._index = param1;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         var _loc1_:int = 0;
         _bg = creatBitmap("asset.fund.itemBg");
         addChild(_bg);
         _costImg = creatBitmap("asset.fund.cost");
         addChild(_costImg);
         _getImg = creatBitmap("asset.fund.get");
         addChild(_getImg);
         _joinBtn = creatComponentByStylename("fund.getBtn");
         addChild(_joinBtn);
         _itemIcon = creatComponentByStylename("fund.LevelImg");
         addChild(_itemIcon);
         _itemIcon.setFrame(this._index + 1);
         _itemCells = new Vector.<FundVeinItemCell>();
         _vBox = new VBox();
         _scrollPanel = creatComponentByStylename("fund.rewardPanel");
         _scrollPanel.setView(_vBox);
         _scrollPanel.y = 236;
         addChild(_scrollPanel);
         _diamondPoints = [new Point(204,146),new Point(164,169),new Point(248,169)];
         _diamondCells = new Vector.<FundVeinDiamondCell>(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _diamondCells[_loc1_] = new FundVeinDiamondCell(_diamondPoints[_loc1_].x);
            _diamondCells[_loc1_].y = _diamondPoints[_loc1_].y;
            addChild(_diamondCells[_loc1_]);
            _loc1_++;
         }
      }
      
      public function updateView(param1:LevelInfo) : void
      {
         var _loc3_:FundVeinItemCell = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this._needPoint = param1.needPoint;
         this._level = param1.level;
         _itemIcon.tipData = param1.gridTipsData;
         var _loc2_:Array = param1.infoMsg;
         _loc2_.sortOn(["sortValue","index"],16);
         var _loc4_:int = int(_loc2_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = getItemCell(_loc6_);
            _loc3_.udpateView(_loc2_[_loc6_],param1.isBuy);
            _vBox.addChild(_itemCells[_loc6_]);
            _loc6_++;
         }
         _vBox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         _diamondCells[0].update(param1.needPoint);
         var _loc5_:int = _diamondCells.length - 1;
         _loc4_ = int(param1.allTakedInfo.length);
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            if(_loc7_ < _loc5_)
            {
               _diamondCells[_loc7_ + 1].updateView(param1.allTakedInfo[_loc7_]);
            }
            _loc7_++;
         }
         _joinBtn.enable = !param1.isBuy;
      }
      
      private function getItemCell(param1:int) : FundVeinItemCell
      {
         if(_itemCells.length > param1)
         {
            return _itemCells[param1];
         }
         _itemCells[param1] = new FundVeinItemCell(this._level);
         return _itemCells[param1];
      }
      
      private function creatComponentByStylename(param1:String) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1);
      }
      
      private function creatBitmap(param1:String) : Bitmap
      {
         return ComponentFactory.Instance.creatBitmap(param1);
      }
      
      private function initEvent() : void
      {
         _joinBtn.addEventListener("click",onJoinBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.removeEventListener("click",onJoinBtnClickHandler);
      }
      
      private function onJoinBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:String = _needPoint.toString();
         _loc3_ += LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
         var _loc2_:String = LanguageMgr.GetTranslation("fund.FundBuyItem.buyPrompt.NewbieText",_loc3_);
         SimpleAlertHelper.instance.data = [payMoneyHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      private function payMoneyHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _needPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            FundVeinManager.instance.fundOperate(1,this._level);
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:FundVeinDiamondCell = null;
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_costImg);
         _costImg = null;
         ObjectUtils.disposeObject(_getImg);
         _getImg = null;
         ObjectUtils.disposeAllGrandson(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeAllGrandson(_joinBtn);
         _joinBtn = null;
         _diamondPoints.length = 0;
         _diamondPoints = null;
         _loc1_ = _diamondCells.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = _diamondCells.pop();
            _loc2_.dispose();
            _loc2_ = null;
            _loc1_--;
         }
         _diamondCells = null;
         ObjectUtils.disposeAllGrandson(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllGrandson(_scrollPanel);
         _scrollPanel = null;
         super.dispose();
         ObjectUtils.disposeSelf(this);
      }
   }
}

