package map.campaign.view.ui.emedream
{
   import battle.view.buffer.BufferIconOnRole;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import utils.LogicUtils;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class EmeDreamBufferView extends Sprite implements Disposeable
   {
      
      private var _buffers:Vector.<BufferTemplateInfo>;
      
      private var _currentIndex:int = 0;
      
      private var _bufferViews:Array = [];
      
      public function EmeDreamBufferView()
      {
         super();
         initEvent();
         __reFreshBuffer("",null);
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS",this,__reFreshBuffer);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS",this,__reFreshBuffer);
      }
      
      private function __reFreshBuffer(param1:String, param2:Object) : void
      {
         reFreshBuffer(ConsortiaManager.instance.model.emeDreamInfo.BufferIds);
      }
      
      private function reFreshBuffer(param1:String) : void
      {
         var _loc4_:BufferTemplateInfo = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         _buffers = new Vector.<BufferTemplateInfo>();
         if(param1)
         {
            _loc2_ = param1.split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc2_[_loc3_]);
               if(_loc4_ && _loc4_.Icon && _loc4_.Icon.length > 0)
               {
                  _buffers.push(_loc4_);
               }
               _loc3_++;
            }
         }
         if(_buffers.length > 0)
         {
            showBuffer();
         }
         else
         {
            removePreBuffer();
         }
      }
      
      private function showBuffer() : void
      {
         var _loc1_:BufferIconOnRole = null;
         removePreBuffer();
         var _loc2_:int = 0;
         if(_buffers && _buffers.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _buffers.length)
            {
               _loc1_ = getBufferView(_buffers[_loc2_]);
               _loc1_.y = 70;
               _loc1_.x = -_loc2_ * (_loc1_.width + 10);
               addChild(_loc1_);
               _bufferViews.push(_loc1_);
               _loc2_++;
            }
         }
      }
      
      private function removePreBuffer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_bufferViews && _bufferViews.length)
         {
            _loc1_ = int(_bufferViews.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               (_bufferViews[_loc2_] as BufferIconOnRole).dispose();
               _bufferViews[_loc2_] = null;
               _loc2_++;
            }
            _bufferViews.length = 0;
         }
      }
      
      private function getBufferView(param1:BufferTemplateInfo) : BufferIconOnRole
      {
         return new BufferIconOnRole(param1.Icon,param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removePreBuffer();
         LogicUtils.disposeDisplayCollection(_buffers);
      }
   }
}

