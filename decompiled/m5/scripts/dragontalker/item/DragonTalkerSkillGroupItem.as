package dragontalker.item
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.DragonTalkerManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   
   public class DragonTalkerSkillGroupItem extends Sprite
   {
      
      private var _lineContainer:Sprite;
      
      private var _skillContainer:Sprite;
      
      public function DragonTalkerSkillGroupItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _skillContainer = new Sprite();
         _lineContainer = new Sprite();
         addChild(_lineContainer);
         addChild(_skillContainer);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_lineContainer);
         _lineContainer = null;
         ObjectUtils.disposeAllChildren(_skillContainer);
         _skillContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function creatItems(param1:Array) : void
      {
         var _loc4_:SkillInfo = null;
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:DragonTalkerSkillItemViewII = null;
         var _loc5_:DragonTalkerLine = null;
         var _loc8_:int = 0;
         var _loc17_:int = 0;
         var _loc16_:int = 0;
         var _loc13_:Boolean = false;
         var _loc18_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         param1.sortOn("templateId",16);
         var _loc2_:Array = [];
         _loc12_ = 0;
         while(_loc12_ < param1.length)
         {
            _loc4_ = param1[_loc12_];
            _loc2_.push(_loc4_.templateInfo.Index);
            _loc12_++;
         }
         var _loc15_:int = 70;
         var _loc10_:int = 15;
         var _loc7_:int = 53;
         var _loc19_:int = 20;
         var _loc14_:int = _loc2_[_loc2_.length - 1] / 10;
         _loc9_ = 1;
         while(_loc9_ <= _loc14_)
         {
            _loc8_ = 1;
            _loc13_ = true;
            _loc11_ = 1;
            while(_loc11_ <= 5)
            {
               _loc6_ = _loc9_ * 10 + _loc11_;
               _loc18_ = _loc2_.indexOf(_loc6_);
               if(_loc18_ != -1)
               {
                  _loc4_ = param1[_loc18_];
                  _loc3_ = new DragonTalkerSkillItemViewII();
                  _loc3_.data = _loc4_;
                  _loc3_.x = _loc15_ + (_loc11_ - 1) * 108;
                  _loc3_.y = _loc10_ + (_loc9_ - 1) * 68;
                  model.addSkillItem(_loc4_.templateId,_loc3_);
                  _skillContainer.addChild(_loc3_);
                  _loc17_ = _loc11_ - _loc8_;
                  if(_loc17_ > 0)
                  {
                     _loc5_ = new DragonTalkerLine();
                     _loc5_.light = false;
                     _loc5_.name = "" + _loc6_;
                     model.addSkillLine(_loc4_.templateId,_loc5_);
                     if(_loc9_ > 1)
                     {
                        _loc16_ = _loc13_ ? 2 : 1;
                     }
                     else
                     {
                        _loc16_ = 1;
                     }
                     _loc5_.type = _loc16_;
                     _loc5_.x = _loc15_ + (_loc8_ - 1) * 108 + _loc7_;
                     if(_loc16_ == 2 && _loc13_)
                     {
                        _loc5_.y = _loc10_ + (_loc9_ - 1) * 68 - 17;
                        _loc5_.lineWidth = 108 * _loc17_ - _loc7_ + _loc19_;
                        _loc5_.x -= _loc19_;
                     }
                     else
                     {
                        _loc5_.y = _loc10_ + (_loc9_ - 1) * 68 + 13;
                        _loc5_.lineWidth = 108 * _loc17_ - _loc7_;
                     }
                     _loc13_ = false;
                     _lineContainer.addChild(_loc5_);
                  }
                  _loc8_ = _loc11_;
               }
               _loc11_++;
            }
            _loc9_++;
         }
      }
   }
}

