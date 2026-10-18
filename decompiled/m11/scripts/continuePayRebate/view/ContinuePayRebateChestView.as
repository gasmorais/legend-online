package continuePayRebate.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import funny.datas.FunnyData;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   
   public class ContinuePayRebateChestView extends Sprite implements Disposeable
   {
      
      private static const DAY_NUM:int = 3;
      
      private var _back:MutipleImage;
      
      private var _vbox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _data:Vector.<FunnyData>;
      
      private var _topDayNumVec:Vector.<ContinuePayRebateChestPayItem>;
      
      private var _chestItemVec:Vector.<ContinuePayRebateChestItem>;
      
      private var _lastActiveId:String;
      
      public function ContinuePayRebateChestView()
      {
         super();
         _topDayNumVec = new Vector.<ContinuePayRebateChestPayItem>();
         _chestItemVec = new Vector.<ContinuePayRebateChestItem>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chest.back");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chest.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.chest.panel");
         _panel.setView(_vbox);
         addChild(_back);
         addChild(_panel);
         initTopDayNum();
      }
      
      private function initTopDayNum() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ContinuePayRebateChestPayItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("continuePayRebate.chestPayItem.num" + _loc2_);
            addChild(_loc1_);
            _topDayNumVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function setDayNum(param1:FunnyData) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _topDayNumVec[_loc2_].dayCount = param1.bagList[_loc2_].conditionList[0].bak;
            _loc2_++;
         }
      }
      
      private function createChestItem() : void
      {
         var _loc1_:ContinuePayRebateChestItem = null;
         _vbox.removeAllChild();
         for each(var _loc2_:FunnyData in _data)
         {
            if(_loc2_ && playerModel.nowDate > _loc2_.showStart && playerModel.nowDate < _loc2_.showEnd)
            {
               _loc1_ = new ContinuePayRebateChestItem();
               _chestItemVec.push(_loc1_);
               _vbox.addChild(_loc1_);
               _loc1_.data = _loc2_;
            }
         }
         _panel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:Vector.<FunnyData>) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         _data = param1;
         setDayNum(_data[0]);
         createChestItem();
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         _data = null;
         for each(var _loc2_:ContinuePayRebateChestPayItem in _topDayNumVec)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         for each(var _loc1_:ContinuePayRebateChestItem in _chestItemVec)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc2_ = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

