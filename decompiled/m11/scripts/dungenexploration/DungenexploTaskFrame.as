package dungenexploration
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dungenexploration.item.DungeonrewardItem;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DungeonExploManager;
   import mvc.module.theseus.dungeon.TheseusDungeonModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.TheseusDungeonTaskInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class DungenexploTaskFrame extends Frame implements IManualSize
   {
      
      private var _desTxt:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _rewardSpanel:ScrollPanel;
      
      private var _itemList:Array = [];
      
      public var _rewardVbox:VBox;
      
      private var _dataList:Dictionary = new Dictionary();
      
      private var _currItemList:Array = [];
      
      public function DungenexploTaskFrame()
      {
         super();
         initView();
         initEvent();
         updateRewardHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,583,652);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexpol.gjBigBg");
         addToContent(_bg);
         _rewardSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.rewardSpanel");
         addToContent(_rewardSpanel);
         _rewardVbox = ComponentFactory.Instance.creatCustomObject("ui.dungenexplo.rewardVbox");
         _rewardSpanel.setView(_rewardVbox);
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexpol.gjDesTxt");
         addToContent(_desTxt);
         _desTxt.text = LanguageMgr.GetTranslation("dungenexploration.season.des");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("THESEUS_DUNGEON_TASK_DATA",updateRewardHandler);
      }
      
      private function get model() : TheseusDungeonModel
      {
         return DungeonExploManager.instance.model;
      }
      
      private function updateRewardHandler(param1:NotificationEvent) : void
      {
         var _loc2_:DungeonrewardItem = null;
         var _loc5_:int = 0;
         var _loc3_:TheseusDungeonTaskInfo = null;
         var _loc6_:Array = model.tasks;
         _currItemList.length = 0;
         var _loc4_:int = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ >= _itemList.length)
            {
               _loc2_ = new DungeonrewardItem();
               _itemList.push(_loc2_);
            }
            else
            {
               _loc2_ = _itemList[_loc5_];
            }
            _loc3_ = TempleteManager.instance.theseusDungeonTaskCate.getListById(_loc6_[_loc5_].taskId);
            _loc2_.temp = _loc3_;
            _loc2_.data = _loc6_[_loc5_];
            _currItemList.push(_loc2_);
            _loc5_++;
         }
         sortItemList();
      }
      
      private function sortItemList() : void
      {
         var _loc1_:DungeonrewardItem = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_currItemList.length);
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _currItemList[_loc4_];
            if(_loc1_.data && _loc1_.data.status == 2)
            {
               _loc3_.push(_loc1_);
            }
            else if(_loc1_.data && _loc1_.data.status == 1)
            {
               _loc6_.push(_loc1_);
            }
            else
            {
               _loc5_.push(_loc1_);
            }
            _loc4_++;
         }
         var _loc7_:Array = _loc6_.concat(_loc5_);
         _loc7_ = _loc7_.concat(_loc3_);
         _loc2_ = int(_loc7_.length);
         _rewardVbox.beginChanges();
         _rewardVbox.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _loc7_[_loc4_];
            _rewardVbox.addChild(_loc1_);
            _loc4_++;
         }
         _rewardVbox.commitChanges();
         _rewardSpanel.invalidateViewport();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("THESEUS_DUNGEON_TASK_DATA",updateRewardHandler);
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
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message14");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeAllChildren(this);
         removeEvent();
         super.dispose();
      }
   }
}

