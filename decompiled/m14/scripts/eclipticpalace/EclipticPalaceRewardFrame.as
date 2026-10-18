package eclipticpalace
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.EclipticPalaceManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import mvc.module.fundVein.RewardItemInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class EclipticPalaceRewardFrame extends Frame implements IManualSize
   {
      
      private static const DEFAULT_COUNT:int = 60;
      
      private var _bagScroll:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var itemList:Vector.<BaseItemView>;
      
      public function EclipticPalaceRewardFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         EclipticPalaceManager.instance.sendEclipticPalaceRequest(5);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,345,330);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatCustomObject("EclipticPalaceRewardFrame.rewardList",[6]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceRewardFrame.bagScroll");
         _bagScroll.setView(_list);
         addToContent(_bagScroll);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         itemList = new Vector.<BaseItemView>();
         _list.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 60)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("EclipticPalaceRewardFrame.rewardItem");
            _list.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("REWARD_GOODS_BACK",this,__updateRewardHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("REWARD_GOODS_BACK",this,__updateRewardHandler);
      }
      
      private function __updateRewardHandler(param1:String, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:RewardItemInfo = null;
         _list.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < 60)
         {
            _loc3_ = itemList[_loc5_];
            if(_loc5_ + 1 <= model.rewardList.length)
            {
               _loc6_ = new GoodsInfo();
               _loc4_ = model.rewardList[_loc5_];
               _loc6_.templateId = _loc4_.tempId;
               _loc6_.count = _loc4_.count;
               _loc3_.data = _loc6_;
            }
            else
            {
               _loc3_.data = null;
            }
            _loc5_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
      }
      
      private function get model() : EclipticPalaceModel
      {
         return EclipticPalaceManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.MazeFallItemsFrame.title");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

