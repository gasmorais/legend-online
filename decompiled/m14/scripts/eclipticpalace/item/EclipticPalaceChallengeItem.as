package eclipticpalace.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.EclipticPalaceManager;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import mvc.module.eclipticpalace.EclipticPalaceRouteInfo;
   import utils.LogicUtils;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   
   public class EclipticPalaceChallengeItem extends Component
   {
      
      private var _selectBack:Bitmap;
      
      private var _lineImage:Bitmap;
      
      private var _rewardBack:Bitmap;
      
      private var _rewardImage:ScaleFrameImage;
      
      private var _itemContiner:Component;
      
      private var itemList:Vector.<EclipticPalaceBossItem>;
      
      private var posArr:Array = [[15,-5],[130,20],[245,-15],[360,20]];
      
      private var _pathIndex:int;
      
      private var _data:EclipticPalaceRouteInfo;
      
      public function EclipticPalaceChallengeItem(param1:int)
      {
         super();
         _pathIndex = param1;
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _selectBack = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceChallengeItem.selectBack");
         _lineImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceChallengeItem.lineImage");
         _rewardBack = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceChallengeItem.rewardBack");
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceChallengeItem.rewardImage");
         _itemContiner = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceChallengeItem.itemContiner");
         addChild(_selectBack);
         addChild(_lineImage);
         addChild(_itemContiner);
         addChild(_rewardBack);
         addChild(_rewardImage);
         _rewardImage.setFrame(1);
         _selectBack.visible = false;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EclipticPalaceBossItem = null;
         itemList = new Vector.<EclipticPalaceBossItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new EclipticPalaceBossItem(_loc2_,_pathIndex);
            _loc1_.x = posArr[_loc2_][0];
            _loc1_.y = posArr[_loc2_][1];
            _itemContiner.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__selectItemHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__selectItemHandler);
      }
      
      public function get data() : EclipticPalaceRouteInfo
      {
         return _data;
      }
      
      public function set data(param1:EclipticPalaceRouteInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:EclipticPalaceBossItem = null;
         var _loc2_:int = int(model.selectedRoute != 0 ? model.selectedRoute : int(model.selectPath));
         _selectBack.visible = _pathIndex == _loc2_ ? true : false;
         if(!data)
         {
            return;
         }
         setReward();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = itemList[_loc3_];
            _loc1_.data = data.getBossInfoByIndex(_loc3_);
            _loc3_++;
         }
         if(model.selectedRoute != 0 && model.selectedRoute != _pathIndex)
         {
            this.filters = [UIFilter.getGrayFilter()];
         }
         else
         {
            this.filters = [];
         }
      }
      
      private function __selectItemHandler(param1:MouseEvent) : void
      {
         if(model.selectedRoute != 0)
         {
            return;
         }
         model.selectPath = _pathIndex;
      }
      
      private function setReward() : void
      {
         data.hasPass ? _rewardImage.setFrame(2) : _rewardImage.setFrame(1);
         var _loc1_:Array = TempleteManager.instance.eclipticPalaceRewardCate.getEpShowRewards(model.curLayer,true);
         var _loc2_:Array = TempleteManager.instance.eclipticPalaceRewardCate.getEpShowRewards(model.curLayer,false);
         var _loc3_:String = LanguageMgr.GetTranslation("EclipticPalaceChallengeItem.rewardImage.tipData") + "\n";
         var _loc4_:String = LanguageMgr.GetTranslation("EclipticPalaceChallengeItem.rewardImage.rateReward") + "\n";
         if(_loc2_.length > 0)
         {
            _rewardImage.tipData = _loc3_ + GoodsHelp.getRewardDesc2(_loc1_) + "\n" + _loc4_ + GoodsHelp.getRewardDesc2(_loc2_);
         }
         else
         {
            _rewardImage.tipData = _loc3_ + GoodsHelp.getRewardDesc2(_loc1_);
         }
      }
      
      private function get model() : EclipticPalaceModel
      {
         return EclipticPalaceManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectBack);
         _selectBack = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_rewardBack);
         _rewardBack = null;
         ObjectUtils.disposeObject(_itemContiner);
         _itemContiner = null;
         ObjectUtils.disposeObject(_rewardImage);
         _rewardImage = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

