package battle.view.ui
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class SelfBufferView extends Sprite implements Disposeable
   {
      
      private var _currentBufferCount:int;
      
      private var _bufferList:Array;
      
      private var _wasteBufferByHero:String;
      
      private var bufferIcons:SimpleDictionary = new SimpleDictionary();
      
      public function SelfBufferView()
      {
         super();
         _wasteBufferByHero = BaseManager.instance.wasteBossBufferIdByHero;
         initWasteBossBufferView();
         initConsortiaEmeDreamBufferView();
         initEvent();
      }
      
      private function initConsortiaEmeDreamBufferView() : void
      {
         var _loc1_:String = null;
         var _loc6_:BufferTemplateInfo = null;
         var _loc4_:* = undefined;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:BufferDamageData = null;
         if(BattleManager.getInstance().battleModel.battleType == 309)
         {
            _loc1_ = ConsortiaManager.instance.model.emeDreamInfo.BufferIds;
            if(_loc1_)
            {
               _loc4_ = new Vector.<BufferDamageData>();
               _loc2_ = _loc1_.split(",");
               _loc5_ = 2;
               while(_loc5_ < _loc2_.length)
               {
                  _loc6_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc2_[_loc5_]);
                  if(_loc6_ && _loc6_.Icon && _loc6_.Icon.length > 0)
                  {
                     _loc3_ = new BufferDamageData();
                     _loc3_.templateId = _loc6_.Id;
                     _loc4_.push(_loc3_);
                  }
                  _loc5_++;
               }
               reFreshBuffer(_loc4_);
            }
         }
      }
      
      private function initWasteBossBufferView() : void
      {
         var _loc5_:BufferTemplateInfo = null;
         var _loc2_:* = undefined;
         var _loc1_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:BufferDamageData = null;
         if(BattleManager.getInstance().battleModel.battleType == 3853)
         {
            if(_wasteBufferByHero)
            {
               _loc2_ = new Vector.<BufferDamageData>();
               _loc1_ = _wasteBufferByHero.split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc1_.length)
               {
                  _loc5_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc1_[_loc4_]);
                  if(_loc5_ && _loc5_.Icon && _loc5_.Icon.length > 0)
                  {
                     _loc3_ = new BufferDamageData();
                     _loc3_.templateId = _loc5_.Id;
                     _loc2_.push(_loc3_);
                  }
                  _loc4_++;
               }
               reFreshBuffer(_loc2_);
            }
         }
      }
      
      private function initEvent() : void
      {
         roleInfo.addEventListener("REFRESH_BUFFER",__reFreshBuffer);
         roleInfo.addEventListener("REFRESH_BUFFER_TURN",refreshBufferTurn);
      }
      
      protected function refreshBufferTurn(param1:RoleEvent = null) : void
      {
         var _loc2_:int = 0;
         if(!_bufferList)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _bufferList.length)
         {
            (_bufferList[_loc2_] as SelfBufferIcon).refreshView();
            _loc2_++;
         }
      }
      
      private function removeEvent() : void
      {
         roleInfo.removeEventListener("REFRESH_BUFFER",__reFreshBuffer);
         roleInfo.removeEventListener("REFRESH_BUFFER_TURN",refreshBufferTurn);
      }
      
      private function __reFreshBuffer(param1:RoleEvent) : void
      {
         var _loc2_:BufferTemplateInfo = null;
         removeBuffer();
         initWasteBossBufferView();
         initConsortiaEmeDreamBufferView();
         var _loc4_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         for each(var _loc3_:BufferDamageData in param1.data)
         {
            if(_loc3_.currentTurn > 0)
            {
               _loc2_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc3_.templateId);
               if(_loc2_ && _loc2_.Icon && _loc2_.Icon.length > 0)
               {
                  _loc4_.push(_loc3_);
               }
            }
         }
         reFreshBuffer(_loc4_);
      }
      
      private function reFreshBuffer(param1:Vector.<BufferDamageData> = null) : void
      {
         var _loc2_:SelfBufferIcon = null;
         for each(var _loc3_:BufferDamageData in param1)
         {
            _loc2_ = bufferIcons[_loc3_.id];
            if(!_loc2_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("battle.SelfBufferIcon");
               bufferIcons.add(_loc3_.id,_loc2_);
            }
            _loc2_.buffer = _loc3_;
            layerOutBuffer(_loc2_);
         }
         _bufferList = bufferIcons.getList();
      }
      
      private function layerOutBuffer(param1:SelfBufferIcon) : void
      {
         param1.y = int(_currentBufferCount / 4) * (-param1.iconHeight - 4);
         param1.x = int(_currentBufferCount % 4) * (param1.iconWidth + 4);
         if(!param1.parent)
         {
            addChild(param1);
         }
         _currentBufferCount = _currentBufferCount + 1;
      }
      
      private function removeBuffer() : void
      {
         var _loc1_:SelfBufferIcon = null;
         var _loc3_:int = 0;
         _currentBufferCount = 0;
         if(!_bufferList)
         {
            return;
         }
         var _loc2_:int = int(_bufferList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _bufferList[_loc3_];
            if(_loc1_.parent)
            {
               this.removeChild(_loc1_);
            }
            _loc3_++;
         }
      }
      
      private function removeAllBuffer() : void
      {
         var _loc1_:SelfBufferIcon = null;
         _currentBufferCount = 0;
         if(!bufferIcons)
         {
            return;
         }
         for each(_loc1_ in bufferIcons)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         bufferIcons.clear();
         bufferIcons = null;
         _bufferList = null;
      }
      
      public function setScale(param1:Number) : void
      {
         for each(var _loc2_:SelfBufferIcon in _bufferList)
         {
            _loc2_.iconHeight *= param1;
            _loc2_.iconWidth *= param1;
         }
      }
      
      private function get roleInfo() : HeroRoleInfo
      {
         return BattleManager.getInstance().battleModel.selfHero;
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeAllBuffer();
      }
   }
}

