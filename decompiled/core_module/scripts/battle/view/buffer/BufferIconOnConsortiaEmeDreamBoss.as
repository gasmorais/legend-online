package battle.view.buffer
{
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   
   public class BufferIconOnConsortiaEmeDreamBoss extends BufferIconOnRole
   {
      
      private var _index:int = -1;
      
      public function BufferIconOnConsortiaEmeDreamBoss(param1:String, param2:Object, param3:int)
      {
         _index = param3;
         super(param1,param2);
         addEvent();
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS",this,__reFreshBuffer);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS",this,__reFreshBuffer);
      }
      
      private function __reFreshBuffer(param1:String, param2:Object) : void
      {
         var _loc5_:BufferTemplateInfo = null;
         var _loc4_:Array = null;
         var _loc3_:String = ConsortiaManager.instance.model.emeDreamInfo.BufferIds;
         if(_loc3_)
         {
            _loc4_ = _loc3_.split(",");
            _loc5_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc4_[_index]);
            if(_loc5_ && _loc5_.Icon && _loc5_.Icon.length > 0)
            {
               _buffer = _loc5_;
            }
         }
         if(_iconView && _loc5_)
         {
            _iconView.tipData = _loc5_;
            _iconView.icon = IconFactory.getCommonIconPath(_loc5_.Icon);
         }
         else
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

