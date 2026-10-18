package secretadventure.map
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretEventInfo;
   import mvc.module.secret.SecretMapInfo;
   import secretadventure.item.SecretHexagon;
   import secretadventure.util.SecretHexagonTool;
   import yishi.datas.templates.SecretEventTemplate;
   import yishi.datas.templates.SecretMapDataTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class SecretSonMapView extends Sprite
   {
      
      private var _mapTemp:SecretMapDataTemplate;
      
      private var _mapInfo:SecretMapInfo;
      
      private var _nodeDic:SimpleDictionary = new SimpleDictionary();
      
      private var _mapType:int;
      
      private const OFF_X:int = 240;
      
      private const OFF_Y:int = 160;
      
      private var _gray:Array;
      
      public function SecretSonMapView(param1:int)
      {
         super();
         _mapType = param1;
         _gray = [UIFilter.getGrayFilter()];
      }
      
      public function setMapTemp(param1:SecretMapDataTemplate, param2:Boolean = false) : void
      {
         var _loc6_:SecretEventInfo = null;
         var _loc27_:int = 0;
         var _loc15_:Array = null;
         var _loc24_:String = null;
         var _loc18_:Array = null;
         var _loc11_:int = 0;
         var _loc16_:Array = null;
         var _loc25_:String = null;
         var _loc3_:int = 0;
         var _loc26_:Array = null;
         var _loc19_:int = 0;
         var _loc21_:int = 0;
         var _loc10_:SecretHexagon = null;
         var _loc13_:int = 0;
         _loc13_ = 106;
         var _loc7_:int = 0;
         _loc7_ = 94;
         var _loc20_:int = 0;
         var _loc22_:int = 0;
         var _loc17_:Number = NaN;
         var _loc29_:int = 0;
         var _loc14_:Array = null;
         var _loc23_:Array = null;
         var _loc8_:SecretHexagon = null;
         var _loc4_:Array = TempleteManager.instance.secretEventCate.getEventTempByFunType(1);
         var _loc12_:SecretEventTemplate = _loc4_[0];
         var _loc28_:int = int(_loc12_.Id);
         if(this._mapTemp)
         {
            _loc15_ = _nodeDic.getList();
            for each(var _loc5_:SecretHexagon in _loc15_)
            {
               _loc27_ = _loc5_.getId();
               _loc6_ = _mapInfo.getNdInfo(_loc27_);
               if(_loc6_)
               {
                  _loc5_.eventInfo = _loc6_;
               }
               else
               {
                  _loc5_.nodeEventId(_loc28_);
               }
            }
            return;
         }
         this._mapTemp = param1;
         if(param1)
         {
            _loc24_ = param1.MapDatas;
            _loc18_ = _loc24_.split("|");
            _loc11_ = int(_loc18_.length);
            _loc26_ = [];
            _loc19_ = 0;
            while(_loc19_ < _loc11_)
            {
               _loc25_ = _loc18_[_loc19_];
               _loc16_ = _loc25_.split(",");
               _loc26_.push(_loc16_);
               if(_loc16_.length > _loc3_)
               {
                  _loc3_ = int(_loc16_.length);
               }
               _loc19_++;
            }
            _loc20_ = 0;
            while(_loc20_ < _loc11_)
            {
               _loc16_ = _loc26_[_loc20_];
               _loc22_ = 0;
               while(_loc22_ < _loc3_)
               {
                  _loc21_ = int(_loc16_[_loc22_]);
                  if(_loc21_ != 0)
                  {
                     _loc27_ = _loc20_ * _loc3_ + _loc22_;
                     _loc10_ = new SecretHexagon(_mapType,param1.Id);
                     _loc10_.setId(_loc27_);
                     if(param2)
                     {
                        if(_loc21_ == -1)
                        {
                           _loc10_.nodeEventId(_loc28_);
                        }
                        else if(model.isTest)
                        {
                           _loc4_ = TempleteManager.instance.secretEventCate.getEventTempByType(_loc21_);
                           _loc12_ = _loc4_[0];
                           if(_loc12_)
                           {
                              _loc6_ = new SecretEventInfo();
                              _loc6_.eventId = _loc12_.Id;
                              _loc6_.nodeId = _loc27_;
                              _loc6_.mapDataId = param1.Id;
                              _loc6_.state = 0;
                              if(_mapInfo)
                              {
                                 _mapInfo.addNdInfo(_loc27_,_loc6_);
                              }
                              _loc10_.eventInfo = _loc6_;
                           }
                        }
                        else
                        {
                           _loc6_ = _mapInfo.getNdInfo(_loc27_);
                           if(_loc6_)
                           {
                              _loc10_.eventInfo = _loc6_;
                           }
                        }
                     }
                     _loc17_ = 0;
                     if(_loc20_ % 2 != 0)
                     {
                        _loc17_ = _loc13_ / 2;
                     }
                     _loc10_.x = 240 + _loc13_ * _loc22_ - _loc17_;
                     _loc10_.y = 160 + (_loc7_ - _loc7_ / 4) * _loc20_;
                     _nodeDic.add(_loc27_,_loc10_);
                     addChild(_loc10_);
                     _loc10_.setThitArea(this);
                  }
                  _loc22_++;
               }
               _loc20_++;
            }
            for each(_loc10_ in _nodeDic)
            {
               _loc29_ = _loc10_.getId();
               _loc19_ = Math.floor(_loc29_ / _loc3_);
               if(_loc19_ % 2 == 0)
               {
                  _loc14_ = SecretHexagonTool.getNearIdList(_loc29_,_loc3_,_loc11_,1);
               }
               else
               {
                  _loc14_ = SecretHexagonTool.getNearIdList(_loc29_,_loc3_,_loc11_,-1);
               }
               _loc23_ = _loc10_.getNeighborList();
               for each(var _loc9_:int in _loc14_)
               {
                  _loc8_ = this._nodeDic[_loc9_];
                  if(_loc8_)
                  {
                     _loc23_.push(_loc8_);
                  }
               }
            }
         }
         model.putMapNodes(param1.Id,_nodeDic);
         model.putMap(param1.Id,this);
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function set mapInfo(param1:SecretMapInfo) : void
      {
         var _loc2_:SecretMapDataTemplate = null;
         _mapInfo = param1;
         if(_mapInfo)
         {
            _loc2_ = TempleteManager.instance.secretSonDataCate.getTempInfo(_mapInfo.mapDataId);
            setMapTemp(_loc2_,true);
            this.filters = null;
         }
         else
         {
            this.filters = _gray;
         }
      }
      
      public function updateNodeSState(param1:int, param2:Array) : void
      {
         var _loc4_:SecretHexagon = null;
         for each(var _loc3_:SecretEventInfo in param2)
         {
            _loc4_ = model.getNode(param1,_loc3_.nodeId) as SecretHexagon;
            if(_loc4_)
            {
               _loc4_.eventInfo = _loc3_;
            }
         }
      }
      
      public function clearToGray() : void
      {
         this.filters = _gray;
         var _loc1_:Array = _nodeDic.getList();
         for each(var _loc2_:SecretHexagon in _loc1_)
         {
            _loc2_.clearToGray();
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:SecretHexagon in _nodeDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         if(_nodeDic)
         {
            _nodeDic.clear();
         }
         _nodeDic = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _mapTemp = null;
         _gray = null;
         _mapInfo = null;
      }
   }
}

