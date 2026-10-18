package areslords
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class AresLordsSkillFrame extends Frame implements IManualSize
   {
      
      private var _list:ListPanel;
      
      private var _titleImg:Image;
      
      public function AresLordsSkillFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameTitle");
         _list = ComponentFactory.Instance.creatComponentByStylename("areslords.SkillFrameList");
         addToContent(_titleImg);
         addToContent(_list);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:* = undefined;
         _list.vectorListModel.clear();
         var _loc3_:Dictionary = TempleteManager.instance.skillTemplateDic;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc5_:SkillTempInfo in _loc3_)
         {
            if(_loc5_.MasterType == 301)
            {
               if(_loc4_ == 0)
               {
                  _loc1_ = new Vector.<SkillTempInfo>();
                  _loc2_.push(_loc1_);
               }
               _loc1_.push(_loc5_);
               _loc4_ = (_loc4_ + 1) % 3;
            }
         }
         if(_loc1_)
         {
            while(_loc1_.length < 3)
            {
               _loc1_.push(null);
            }
         }
         _list.vectorListModel.appendAll(_loc2_);
         _list.list.updateListView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,285,260);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

