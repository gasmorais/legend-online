package battle.view.buffer
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class BossBufferContainer extends Component
   {
      
      private var _immuneBuffer:Array;
      
      private var _buffers:Vector.<BufferDamageData>;
      
      private var _permanentBufferList:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
      
      private var _specialBuffers:Vector.<BufferTemplateInfo>;
      
      private var _buffData:Dictionary;
      
      private var _bufferViews:Array = [];
      
      private var _direction:int = 0;
      
      private var _boss:HeroRoleInfo;
      
      private var _bossImmuneBuffs:Array = [];
      
      public function BossBufferContainer(param1:HeroRoleInfo, param2:int = -1)
      {
         super();
         _buffData = new Dictionary();
         _direction = param2;
         initEvent(param1);
         resetBuffer();
         showBuffer();
      }
      
      public function initEvent(param1:HeroRoleInfo) : void
      {
         _boss = param1;
         if(param1)
         {
            showActiveImmuneBuff();
         }
         if(_boss)
         {
            _boss.addEventListener("REFRESH_BUFFER",__reFreshBuffer);
         }
         if(_boss)
         {
            _boss.addEventListener("isLiving",_isLivingHandler);
         }
      }
      
      public function removeEvent() : void
      {
         if(_boss)
         {
            _boss.removeEventListener("REFRESH_BUFFER",__reFreshBuffer);
         }
         if(_boss)
         {
            _boss.removeEventListener("isLiving",_isLivingHandler);
         }
      }
      
      private function _isLivingHandler(param1:RoleEvent) : void
      {
         if(_boss && _boss.isLiving == false)
         {
            _boss.cleanBuffers(false);
         }
         reFreshBuffer(null);
      }
      
      private function __reFreshBuffer(param1:RoleEvent) : void
      {
         reFreshBuffer(param1.data as Vector.<BufferDamageData>);
      }
      
      public function reFreshBuffer(param1:Vector.<BufferDamageData>) : void
      {
         var _loc3_:BufferTemplateInfo = null;
         var _loc2_:int = 0;
         resetBuffer();
         _buffers = new Vector.<BufferDamageData>();
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_].currentTurn > 0)
               {
                  _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1[_loc2_].templateId);
                  if(_loc3_ && _loc3_.Icon && _loc3_.Icon.length > 0)
                  {
                     _buffers.push(param1[_loc2_]);
                  }
               }
               _loc2_++;
            }
         }
         removeChildPreBuffer();
         if(_boss == null || _boss.isLiving == false)
         {
            return;
         }
         if(_buffers && _buffers.length > 0 || _immuneBuffer && _immuneBuffer.length > 0 || _specialBuffers && _specialBuffers.length > 0 || _permanentBufferList && _permanentBufferList.length > 0)
         {
            showBuffer();
         }
      }
      
      private function showBuffer() : void
      {
         var _loc2_:BufferIconOnRole = null;
         _bufferViews = [];
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         if(_buffers)
         {
            _loc3_ = 0;
            while(_loc3_ < _buffers.length)
            {
               _loc2_ = getBufferViewByDamageData(_buffers[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * _direction;
               addChild(_loc2_);
               _bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(_permanentBufferList)
         {
            _loc3_ = 0;
            while(_loc3_ < _permanentBufferList.length)
            {
               _loc2_ = getBufferViewByDamageData(_permanentBufferList[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * _direction;
               addChild(_loc2_);
               _bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(_specialBuffers)
         {
            _loc3_ = 0;
            while(_loc3_ < _specialBuffers.length)
            {
               _loc2_ = getBufferViewByTempInfo(_specialBuffers[_loc3_]);
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * _direction;
               addChild(_loc2_);
               _bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
         if(_immuneBuffer)
         {
            _loc3_ = 0;
            while(_loc3_ < _bossImmuneBuffs.length)
            {
               _loc2_ = _bossImmuneBuffs[_loc3_] as BufferIconOnRole;
               _loc2_.y = 70;
               _loc2_.x = _loc1_ * (_loc2_.width + 10) * _direction;
               addChild(_loc2_);
               _bufferViews.push(_loc2_);
               _loc1_++;
               _loc3_++;
            }
         }
      }
      
      private function showActiveImmuneBuff() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BufferIconOnRole = null;
         _bossImmuneBuffs = [];
         if(!StringHelper.isNullOrEmpty(_boss.heroInfo.templateInfo.RejectType))
         {
            _immuneBuffer = _boss.heroInfo.templateInfo.RejectType.split(",");
            if(_immuneBuffer)
            {
               _loc2_ = 0;
               while(_loc2_ < _immuneBuffer.length)
               {
                  _loc1_ = getImmuneBufferView(_immuneBuffer[_loc2_]);
                  if(_loc1_)
                  {
                     _bossImmuneBuffs.push(_loc1_);
                  }
                  _loc2_++;
               }
            }
         }
      }
      
      private function removeChildPreBuffer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_bufferViews && _bufferViews.length)
         {
            _loc1_ = int(_bufferViews.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(_bufferViews[_loc2_].parent)
               {
                  _bufferViews[_loc2_].parent.removeChild(_bufferViews[_loc2_]);
               }
               _loc2_++;
            }
         }
      }
      
      private function removeAllBuffer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_bufferViews && _bufferViews.length)
         {
            _loc1_ = int(_bufferViews.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               ObjectUtils.disposeObject(_bufferViews[_loc2_]);
               _bufferViews[_loc2_] = null;
               _loc2_++;
            }
            _bufferViews.length = 0;
         }
      }
      
      private function getBufferViewByDamageData(param1:BufferDamageData) : BufferIconOnRole
      {
         var _loc3_:BufferTemplateInfo = null;
         var _loc2_:BufferIconOnRole = _buffData[param1.bufferUser + "_" + param1.templateId];
         if(_loc2_ == null)
         {
            _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1.templateId);
            _loc2_ = new BufferIconOnRole(_loc3_.Icon,param1);
            _buffData[param1.bufferUser + "_" + param1.templateId] = _loc2_;
         }
         _loc2_.buffer = param1;
         _loc2_.refreshTurn();
         return _loc2_;
      }
      
      private function getBufferViewByTempInfo(param1:BufferTemplateInfo) : BufferIconOnRole
      {
         var _loc2_:BufferIconOnRole = _buffData[param1.Id];
         if(_loc2_ == null)
         {
            _loc2_ = new BufferIconOnRole(param1.Icon,param1);
            _buffData[param1.Id] = _loc2_;
         }
         _loc2_.buffer = param1;
         _loc2_.refreshTurn();
         return _loc2_;
      }
      
      private function getImmuneBufferView(param1:int) : BufferIconOnRole
      {
         var _loc3_:BufferTemplateInfo = null;
         var _loc2_:BufferIconOnRole = _buffData[param1];
         if(_loc2_ == null)
         {
            _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1);
            if(!_loc3_)
            {
               return null;
            }
            _loc2_ = new BufferIconOnRole(_loc3_.Icon,_loc3_);
            _buffData[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function resetBuffer() : void
      {
         var _loc4_:String = null;
         var _loc3_:BufferTemplateInfo = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(_boss != null)
         {
            if(BattleManager.getInstance().battleModel.battleType == 3853)
            {
               _loc4_ = BaseManager.instance.wasteBossBufferIdByBoss;
            }
            if(_loc4_ && _loc4_ != "")
            {
               _specialBuffers = new Vector.<BufferTemplateInfo>();
               _loc1_ = _loc4_.split(",");
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  _loc3_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc1_[_loc2_]);
                  if(_loc3_ && _loc3_.Icon && _loc3_.Icon.length > 0)
                  {
                     _specialBuffers.push(_loc3_);
                  }
                  _loc2_++;
               }
            }
            else
            {
               _boss.pushPermanentBufferDamageDatas(_permanentBufferList);
            }
         }
      }
      
      public function refreshTurn() : void
      {
         var _loc1_:int = 0;
         if(_bufferViews && _bufferViews.length)
         {
            _loc1_ = 0;
            while(_loc1_ < _bufferViews.length)
            {
               if(contains(_bufferViews[_loc1_] as BufferIconOnRole))
               {
                  (_bufferViews[_loc1_] as BufferIconOnRole).refreshTurn();
               }
               _loc1_++;
            }
         }
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
      }
      
      public function disposeBossInfo(param1:HeroRoleInfo) : void
      {
         if(!param1 || !_boss || param1.livingId == _boss.livingId)
         {
            removeEvent();
            removeChildPreBuffer();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         removeEvent();
         removeAllBuffer();
         if(_buffData)
         {
            for each(var _loc3_:String in _buffData)
            {
               delete _buffData[_loc3_];
            }
            _buffData = null;
         }
         _immuneBuffer = null;
         _permanentBufferList = null;
         _specialBuffers = null;
         _buffers = null;
         if(_bossImmuneBuffs && _bossImmuneBuffs.length)
         {
            _loc1_ = int(_bossImmuneBuffs.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               ObjectUtils.disposeObject(_bossImmuneBuffs[_loc2_]);
               _bossImmuneBuffs[_loc2_] = null;
               _loc2_++;
            }
            _bossImmuneBuffs.length = 0;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

