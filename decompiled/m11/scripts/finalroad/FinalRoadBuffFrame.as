package finalroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.finalroad.FinalRoadGroupInfo;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.FinalRoadEventTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class FinalRoadBuffFrame extends Frame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _vBox:VBox;
      
      private var _spanel:ScrollPanel;
      
      public function FinalRoadBuffFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("finalRoadBuffFrame.titleText.text");
         _bg = ComponentFactory.Instance.creatComponentByStylename("finalRoadBuffFrame.bg");
         _vBox = ComponentFactory.Instance.creatCustomObject("finalRoadBuffFrame.vBox");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("finalRoadBuffFrame.spanel");
         addToContent(_bg);
         addToContent(_spanel);
         _spanel.setView(_vBox);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,330,525);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
      }
      
      private function __finalRoadChapterHandler(param1:String, param2:Object) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      public function refreshView() : void
      {
         var _loc8_:int = 0;
         var _loc6_:Array = null;
         var _loc2_:int = 0;
         var _loc10_:FinalRoadEventTempInfo = null;
         var _loc5_:Array = null;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc4_:FilterFrameText = null;
         if(!data)
         {
            return;
         }
         _vBox.removeAllChild();
         _vBox.beginChanges();
         var _loc1_:Array = data.levelSkills.split("|");
         _loc8_ = 0;
         while(_loc8_ < _loc1_.length)
         {
            _loc6_ = _loc1_[_loc8_].split(",");
            _loc2_ = int(_loc6_[1]);
            _loc10_ = TempleteManager.instance.finalRoadEventTempCate.getTempInfoById(_loc2_);
            if(_loc10_)
            {
               _loc5_ = _loc10_.Para1.split(",");
               _loc9_ = 0;
               while(_loc9_ < _loc5_.length)
               {
                  _loc3_ = int(_loc5_[_loc9_]);
                  _loc7_ = TempleteManager.instance.skillTemplateDic[_loc3_];
                  if(_loc7_)
                  {
                     _loc4_ = ComponentFactory.Instance.creatComponentByStylename("finalRoadBuffFrame.txt");
                     _loc4_.text = _loc7_.Description;
                     _loc4_.height = _loc4_.numLines * 20;
                     _vBox.addChild(_loc4_);
                  }
                  _loc9_++;
               }
            }
            _loc8_++;
         }
         _vBox.commitChanges();
         _spanel.invalidateViewport();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : FinalRoadModel
      {
         return FinalRoadManager.instance.model;
      }
      
      private function get data() : FinalRoadGroupInfo
      {
         return model.groupInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_spanel);
         _spanel = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

