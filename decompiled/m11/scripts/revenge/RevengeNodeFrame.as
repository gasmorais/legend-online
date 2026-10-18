package revenge
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mvc.module.revenge.RevengeModel;
   import revenge.item.RevengeNodeItem;
   import revenge.view.RevengeNodeView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class RevengeNodeFrame extends Frame implements IManualSize
   {
      
      private var _view:RevengeNodeView;
      
      private var _posList:Array = [[12,-5],[198,-5],[382,-5],[382,152],[198,152],[12,152],[12,305],[198,305],[382,305]];
      
      private var _nodeList:Vector.<RevengeNodeItem>;
      
      private var _mapId:int;
      
      public function RevengeNodeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,862,480);
      }
      
      private function get model() : RevengeModel
      {
         return RevengeRoadManager.Ins.model;
      }
      
      private function initView() : void
      {
         _view = new RevengeNodeView();
         addToContent(_view);
         creatNodes();
      }
      
      private function creatNodes() : void
      {
         var _loc1_:RevengeNodeItem = null;
         var _loc2_:int = 0;
         _nodeList = new Vector.<RevengeNodeItem>();
         _loc2_ = 0;
         while(_loc2_ < _posList.length)
         {
            _loc1_ = new RevengeNodeItem();
            _loc1_.x = _posList[_loc2_][0];
            _loc1_.y = _posList[_loc2_][1];
            _loc1_.buttonMode = true;
            _view.addChild(_loc1_);
            _nodeList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function refreshNodeNames() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = (_mapId - 1) * 10 + _loc3_ + 1;
            _loc1_ = "" + _loc2_;
            if(_loc3_ < 9)
            {
               _nodeList[_loc3_].name = _loc1_;
               _nodeList[_loc3_].setIdx(_mapId,_loc3_ + 1);
            }
            else
            {
               _view._bossBtn.name = _loc1_;
            }
            _loc3_++;
         }
      }
      
      private function creatBossRewards() : void
      {
         var _loc1_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         if(_view._hbox.numChildren > 0)
         {
            return;
         }
         var _loc6_:int = _mapId * 10;
         var _loc2_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_loc6_);
         if(_loc2_)
         {
            titleText = _loc2_.Name;
            _loc1_ = TempleteManager.instance.revengeRoadDropCate.getDropsById(_loc2_.AttackDropId);
            _loc1_.sortOn("count",0x10 | 2);
            _view._hbox.beginChanges();
            for each(var _loc4_:CommonDropTempInfo in _loc1_)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc4_.itemId;
               _loc5_.count = _loc4_.count;
               _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc3_.data = _loc5_;
               _view._hbox.addChild(_loc3_);
            }
            _view._hbox.commitChanges();
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         for each(var _loc1_:RevengeNodeItem in _nodeList)
         {
            _loc1_.addEventListener("click",nodeClickHandler);
         }
         _view._bossBtn.addEventListener("click",bossClickHandler);
         NotificationManager.instance.addEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         for each(var _loc1_:RevengeNodeItem in _nodeList)
         {
            _loc1_.removeEventListener("click",nodeClickHandler);
         }
         _view._bossBtn.removeEventListener("click",bossClickHandler);
         NotificationManager.instance.removeEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function dataHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _loc2_ = (_mapId - 1) * 10 + _loc4_ + 1;
            _loc3_ = _loc2_ <= model.nodeId + 1;
            if(_loc4_ < 9)
            {
               _nodeList[_loc4_].mouseEnabled = _loc3_;
               _nodeList[_loc4_].mouseChildren = _loc3_;
               _nodeList[_loc4_].lock = !_loc3_;
               _nodeList[_loc4_].isChoose = _loc3_;
               if(_loc2_ == model.nodeId + 1)
               {
                  _nodeList[_loc4_].isShowfrist = true;
               }
               else
               {
                  _nodeList[_loc4_].isShowfrist = false;
               }
            }
            else
            {
               _view._bossBtn.enable = _loc3_;
            }
            _loc4_++;
         }
      }
      
      private function nodeClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:RevengeNodeItem = param1.currentTarget as RevengeNodeItem;
         _loc3_.isChoose = true;
         var _loc2_:int = int(_loc3_.name);
         FrameControllerManager.instance.openControllerByInfo("revengeroad","fight",_loc2_);
      }
      
      private function bossClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.name);
         FrameControllerManager.instance.openControllerByInfo("revengeroad","fight",_loc2_);
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
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:RevengeNodeItem in _nodeList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _nodeList = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      public function show(param1:int) : void
      {
         _mapId = param1;
         creatBossRewards();
         refreshNodeNames();
         dataHandler();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

