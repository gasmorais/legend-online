package forbiddenboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRecordMsg;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   import yishi.manager.ForbiddenBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ForbiddenRecordFrame extends Frame implements IManualSize
   {
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _index:int = 0;
      
      public var _tips:FilterFrameText;
      
      public function ForbiddenRecordFrame()
      {
         super();
         initView();
         addEvent();
         ForbiddenBossManager.instance.sendRecord();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,650,490);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("forbiddenRecordFrame.titleText");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("forbiddenRecordFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("forbiddenRecordFrame.vBox");
         _tips = ComponentFactory.Instance.creatComponentByStylename("forbiddenRecordFrame.tipstxt");
         addToContent(_scrollPanel);
         _scrollPanel.setView(_vBox);
         addToContent(_tips);
         _tips.text = LanguageMgr.GetTranslation("forbiddenRecordFrame.tips");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("FORBIDDEN_BOSS_RECORD_UPDATE",this,__updateRecordHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("FORBIDDEN_BOSS_RECORD_UPDATE",this,__updateRecordHandler);
      }
      
      private function __updateRecordHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc3_:ForbiddenRecordItem = null;
         var _loc1_:ForbiddenBossRecordMsg = null;
         var _loc5_:ForbiddenBossTempInfo = null;
         var _loc4_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         var _loc2_:Array = model.recordArr.reverse();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc4_];
            _loc5_ = TempleteManager.instance.forbiddenBossTempCate.getTempInfoById(_loc1_.bossId);
            if(_loc5_.Category == _index)
            {
               _loc3_ = new ForbiddenRecordItem();
               _loc3_.data = _loc1_;
               _vBox.addChild(_loc3_);
            }
            _loc4_++;
         }
         _vBox.commitChanges();
         _scrollPanel.invalidateViewport();
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
         if(param1 && param1.frameData)
         {
            _index = param1.frameData as int;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(_scrollPanel);
         _scrollPanel = null;
         super.dispose();
      }
   }
}

