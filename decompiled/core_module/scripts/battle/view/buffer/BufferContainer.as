package battle.view.buffer
{
   import battle.data.BufferDamageData;
   import flash.display.Sprite;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BufferContainer extends Sprite
   {
      
      private var _buffers:Vector.<BufferDamageData>;
      
      private var _currentIndex:int = 0;
      
      private var _currentView:BufferIconOnRole;
      
      private var _flasher:BufferIconFlash;
      
      public function BufferContainer()
      {
         super();
      }
      
      public function reFreshBuffer(param1:Vector.<BufferDamageData>) : void
      {
         var _loc3_:BufferTemplateInfo = null;
         var _loc2_:int = 0;
         _buffers = new Vector.<BufferDamageData>();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1[_loc2_].templateId);
            if(_loc3_ && _loc3_.Icon && _loc3_.Icon.length > 0)
            {
               _buffers.push(param1[_loc2_]);
            }
            _loc2_++;
         }
         if(_buffers.length > 0)
         {
            if(_currentIndex >= _buffers.length)
            {
               _currentIndex = 0;
            }
            showBuffer();
         }
         else if(_currentView && _currentView.parent)
         {
            _currentView.visible = false;
         }
      }
      
      private function refreshBuffonData() : void
      {
         var _loc1_:BufferTemplateInfo = null;
         if(!_currentView)
         {
            _currentView = new BufferIconOnRole();
            this.addChild(_currentView);
         }
         if(_buffers.length > 0)
         {
            _loc1_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_buffers[_currentIndex].templateId);
            _currentView.setData(_loc1_.Icon,_buffers[_currentIndex]);
         }
      }
      
      private function moveNextIndex() : void
      {
         _currentIndex = _currentIndex + 1;
         if(_currentIndex >= _buffers.length)
         {
            _currentIndex = 0;
         }
      }
      
      private function showBuffer() : void
      {
         removeCurrentBuffer();
         refreshBuffonData();
         _currentView.alpha = 0;
         _currentView.visible = true;
         if(_flasher)
         {
            _flasher.dispose();
            _flasher = null;
         }
         if(bufferIconNum() > 1)
         {
            _flasher = new BufferIconFlash(_currentView,showNextBuffer);
         }
         else
         {
            _flasher = new BufferIconFlash(_currentView,null);
         }
      }
      
      private function bufferIconNum() : int
      {
         var _loc2_:Array = [];
         for each(var _loc1_:BufferDamageData in _buffers)
         {
            if(_loc2_.indexOf(_loc1_.templateId) == -1)
            {
               _loc2_.push(_loc1_.templateId);
            }
         }
         return _loc2_.length;
      }
      
      private function removeCurrentBuffer() : void
      {
         if(_currentView && contains(_currentView))
         {
            _currentView.visible = false;
         }
      }
      
      private function showNextBuffer() : void
      {
         removeCurrentBuffer();
         moveNextIndex();
         showBuffer();
      }
      
      public function refreshTurn() : void
      {
         if(_currentView)
         {
            _currentView.refreshTurn();
         }
      }
      
      public function dispose() : void
      {
         if(_currentView)
         {
            _currentView.dispose();
         }
         _currentView = null;
         if(_flasher)
         {
            _flasher.dispose();
            _flasher = null;
         }
         _buffers = null;
      }
   }
}

import com.greensock.TweenLite;
import flash.display.DisplayObject;
import yishi.utils.TimerUtils;

class BufferIconFlash
{
   
   private var _target:DisplayObject;
   
   private var _complete:Function;
   
   private var _tweener:TweenLite;
   
   private var _disposed:Boolean;
   
   public function BufferIconFlash(param1:DisplayObject, param2:Function)
   {
      super();
      _target = param1;
      _complete = param2;
      start();
   }
   
   private function start() : void
   {
      _tweener = TweenLite.to(_target,0.2,{
         "alpha":1,
         "onComplete":onComplete1
      });
   }
   
   private function onComplete1() : void
   {
      _tweener.kill();
      _tweener = null;
      if(_complete != null)
      {
         TimerUtils.setTimeout(startDisappear,1000);
      }
   }
   
   private function startDisappear() : void
   {
      if(!_disposed && _complete != null)
      {
         _tweener = TweenLite.to(_target,0.2,{
            "alpha":0,
            "onComplete":onComplete2
         });
      }
   }
   
   private function onComplete2() : void
   {
      if(!_disposed && _complete != null)
      {
         _complete();
         dispose();
      }
   }
   
   public function dispose() : void
   {
      if(_tweener)
      {
         _tweener.kill();
         _tweener = null;
      }
      _disposed = true;
      _complete = null;
   }
}
