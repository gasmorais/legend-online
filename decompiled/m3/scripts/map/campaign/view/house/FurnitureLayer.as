package map.campaign.view.house
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.helper.house.FurnitureSortHelper;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeModel;
   import yishi.datas.templates.FurnitureTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FurnitureLayer extends Sprite implements Disposeable
   {
      
      public static const MAP_W:int = 1200;
      
      public static const MAP_H:int = 900;
      
      public static const CELL:int = 60;
      
      private var floor:int = 8;
      
      private var wall:int = 5;
      
      private var _corner:Point;
      
      private var _left:Point;
      
      private var _right:Point;
      
      private var _mP:Point;
      
      private var _viewList:Vector.<FurnitureView>;
      
      private var _wallSp:Sprite;
      
      private var _floorSp:Sprite;
      
      private var _groundSp1:Sprite;
      
      private var _groundSp2:Sprite;
      
      private var _carpetSp:Sprite;
      
      private var _renderLayer:Sprite;
      
      private var _drawLayer:Sprite;
      
      private var _greenBmd:BitmapData;
      
      private var _redBmd:BitmapData;
      
      private var _mat:Matrix;
      
      private var _btnSp:Sprite;
      
      public function FurnitureLayer()
      {
         super();
         initData();
         initView();
      }
      
      private function initData() : void
      {
         _corner = new Point(model.info.corner.x,model.info.corner.y);
         floor = model.info.floor;
         wall = model.info.wall;
         _viewList = new Vector.<FurnitureView>();
         cleanList();
         _left = new Point(_corner.x - floor * 60 * Math.sin(3.141592653589793 / 3),_corner.y + floor * 60 * Math.sin(3.141592653589793 / 6) - wall * 60);
         _right = new Point(_corner.x + floor * 60 * Math.sin(3.141592653589793 / 3),_corner.y + floor * 60 * Math.sin(3.141592653589793 / 6) - wall * 60);
         _mP = new Point(-1,-1);
         _greenBmd = ComponentFactory.Instance.creatBitmapData("asset.home.green");
         _redBmd = ComponentFactory.Instance.creatBitmapData("asset.home.red");
         _mat = new Matrix();
      }
      
      public function get btnSp() : Sprite
      {
         return _btnSp;
      }
      
      private function initView() : void
      {
         _groundSp2 = new Sprite();
         _groundSp1 = new Sprite();
         _carpetSp = new Sprite();
         _wallSp = new Sprite();
         _floorSp = new Sprite();
         _renderLayer = new Sprite();
         _drawLayer = new Sprite();
         _btnSp = new Sprite();
         addChild(_groundSp2);
         addChild(_groundSp1);
         addChild(_renderLayer);
         addChild(_carpetSp);
         addChild(_wallSp);
         addChild(_floorSp);
         addChild(_drawLayer);
         addChild(_btnSp);
         refreshFurniture();
      }
      
      public function refreshFurniture() : void
      {
         var _loc1_:* = null;
         cleanList();
         ObjectUtils.disposeAllChildren(_groundSp1);
         ObjectUtils.disposeAllChildren(_groundSp2);
         if(CampaignManager.instance.mapView)
         {
            model.fixUpList.splice(0,model.fixUpList.length);
            if(inHouse)
            {
               model.noFixList = model.selfInfo.storeList1.concat();
               FurnitureSortHelper.dealWith(model.info.layList1,addFurniture);
            }
            else if(inHome)
            {
               model.noFixList = model.selfInfo.storeList2.concat();
               FurnitureSortHelper.dealWith(model.info.layList2,addFurniture);
            }
            setFindPathData();
            _groundSp1.cacheAsBitmap = true;
            _groundSp2.cacheAsBitmap = true;
         }
      }
      
      private function testFurniture(param1:FurnitureInfo) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < model.fixUpList.length)
         {
            if(model.fixUpList[_loc2_].furnitureId == param1.furnitureId)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function addFurniture(param1:FurnitureInfo, param2:Boolean = false, param3:int = -1) : Boolean
      {
         if(!testFurniture(param1))
         {
            return false;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:FurnitureInfo = new FurnitureInfo();
         _loc4_.furnitureId = param1.furnitureId;
         _loc4_.templateId = param1.templateId;
         _loc4_.posX = param1.posX;
         _loc4_.posY = param1.posY;
         _loc4_.rotation = param1.rotation;
         model.fixUpList.push(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < model.noFixList.length)
         {
            if(model.noFixList[_loc5_].furnitureId == _loc4_.furnitureId)
            {
               model.noFixList.splice(_loc5_,1);
            }
            _loc5_++;
         }
         if(_loc4_.templateInfo.Type == 1 && inHouse)
         {
            _loc5_ = 0;
            while(_loc5_ < floor)
            {
               _loc4_ = new FurnitureInfo();
               _loc4_.furnitureId = param1.furnitureId;
               _loc4_.templateId = param1.templateId;
               _loc4_.posX = _loc5_;
               _loc4_.posY = 0;
               _loc4_.rotation = 1;
               addToLayer(_loc4_);
               _loc5_ += _loc4_.width;
            }
            _loc5_ = 0;
            while(_loc5_ < floor)
            {
               _loc4_ = new FurnitureInfo();
               _loc4_.furnitureId = param1.furnitureId;
               _loc4_.templateId = param1.templateId;
               _loc4_.posX = _loc5_;
               _loc4_.posY = 0;
               _loc4_.rotation = 2;
               addToLayer(_loc4_);
               _loc5_ += _loc4_.width;
            }
         }
         else if(_loc4_.templateInfo.Type == 2 && inHouse)
         {
            _loc6_ = 0;
            while(_loc6_ < floor)
            {
               _loc5_ = 0;
               while(_loc5_ < floor)
               {
                  _loc4_ = new FurnitureInfo();
                  _loc4_.furnitureId = param1.furnitureId;
                  _loc4_.templateId = param1.templateId;
                  _loc4_.posX = _loc5_;
                  _loc4_.posY = _loc6_;
                  _loc4_.rotation = 1;
                  addToLayer(_loc4_);
                  _loc5_ += _loc4_.width;
               }
               _loc6_ += _loc4_.height;
            }
            _loc6_ = floor;
            while(_loc6_ < floor + 4)
            {
               _loc5_ = (floor - 4) / 2;
               while(_loc5_ < (floor + 4) / 2)
               {
                  _loc4_ = new FurnitureInfo();
                  _loc4_.furnitureId = param1.furnitureId;
                  _loc4_.templateId = param1.templateId;
                  _loc4_.posX = _loc5_;
                  _loc4_.posY = _loc6_;
                  _loc4_.rotation = 1;
                  addToLayer(_loc4_);
                  _loc5_ += _loc4_.width;
               }
               _loc6_ += _loc4_.height;
            }
         }
         else
         {
            addToLayer(_loc4_,param2,param3);
         }
         return true;
      }
      
      private function addToLayer(param1:FurnitureInfo, param2:Boolean = false, param3:int = -1) : void
      {
         var _loc4_:String = null;
         var _loc5_:FurnitureView = new FurnitureView();
         _loc5_.data = param1;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1.templateInfo)
         {
            switch(int(param1.area))
            {
               case 0:
                  _loc5_.x = _corner.x + (param1.posX - param1.posY) * 60 * Math.sin(3.141592653589793 / 3);
                  _loc5_.y = _corner.y + (param1.posX + param1.posY) * 60 * Math.sin(3.141592653589793 / 6);
                  if(param1.templateInfo.Type != 2 && inHouse)
                  {
                     _loc6_ = int(param1.posX);
                     while(_loc6_ < param1.posX + param1.width)
                     {
                        if(_loc6_ >= model.floorList.length)
                        {
                           break;
                        }
                        _loc7_ = int(param1.posY);
                        while(_loc7_ < param1.posY + param1.height)
                        {
                           if(_loc7_ >= model.floorList[_loc6_].length)
                           {
                              break;
                           }
                           _loc4_ = model.floorList[_loc6_][_loc7_];
                           _loc4_ = _loc4_ + "_" + param1.templateInfo.Type;
                           model.floorList[_loc6_][_loc7_] = _loc4_;
                           _loc7_++;
                        }
                        _loc6_++;
                     }
                  }
                  if(param1.templateInfo.Type == 2 && inHouse)
                  {
                     _groundSp2.addChild(_loc5_);
                  }
                  else if(param1.templateInfo.Type == 3 && inHouse)
                  {
                     _carpetSp.addChild(_loc5_);
                     _viewList.push(_loc5_);
                  }
                  else
                  {
                     if(param3 >= 0)
                     {
                        _floorSp.addChildAt(_loc5_,param3);
                     }
                     else
                     {
                        _floorSp.addChild(_loc5_);
                     }
                     _viewList.unshift(_loc5_);
                  }
                  break;
               case 1:
                  _loc5_.x = _left.x + param1.posX * 60 * Math.sin(3.141592653589793 / 3);
                  _loc5_.y = _left.y + param1.posY * 60 - param1.posX * 60 * Math.sin(3.141592653589793 / 6);
                  _loc6_ = int(param1.posX);
                  while(_loc6_ < param1.posX + param1.width)
                  {
                     if(_loc6_ >= model.leftList.length)
                     {
                        break;
                     }
                     _loc7_ = int(param1.posY);
                     while(_loc7_ < param1.posY + param1.height)
                     {
                        if(_loc7_ >= model.leftList[_loc6_].length)
                        {
                           break;
                        }
                        _loc4_ = model.leftList[_loc6_][_loc7_];
                        _loc4_ = _loc4_ + "_" + param1.templateInfo.Type;
                        model.leftList[_loc6_][_loc7_] = _loc4_;
                        _loc7_++;
                     }
                     _loc6_++;
                  }
                  if(param1.templateInfo.Type == 1 && inHouse)
                  {
                     _groundSp1.addChildAt(_loc5_,0);
                  }
                  else if(param1.templateInfo.Type == 9 && inHouse)
                  {
                     _carpetSp.addChild(_loc5_);
                     _viewList.push(_loc5_);
                  }
                  else
                  {
                     if(param3 >= 0)
                     {
                        _wallSp.addChildAt(_loc5_,param3);
                     }
                     else
                     {
                        _wallSp.addChild(_loc5_);
                     }
                     _viewList.unshift(_loc5_);
                  }
                  break;
               case 2:
                  _loc5_.x = _corner.x + param1.posX * 60 * Math.sin(3.141592653589793 / 3);
                  _loc5_.y = _corner.y - wall * 60 + param1.posY * 60 + param1.posX * 60 * Math.sin(3.141592653589793 / 6);
                  _loc6_ = int(param1.posX);
                  while(_loc6_ < param1.posX + param1.width)
                  {
                     if(_loc6_ >= model.rightList.length)
                     {
                        break;
                     }
                     _loc7_ = int(param1.posY);
                     while(_loc7_ < param1.posY + param1.height)
                     {
                        if(_loc7_ >= model.rightList[_loc6_].length)
                        {
                           break;
                        }
                        _loc4_ = model.rightList[_loc6_][_loc7_];
                        _loc4_ = _loc4_ + "_" + param1.templateInfo.Type;
                        model.rightList[_loc6_][_loc7_] = _loc4_;
                        _loc7_++;
                     }
                     _loc6_++;
                  }
                  if(param1.templateInfo.Type == 1 && inHouse)
                  {
                     _groundSp1.addChild(_loc5_);
                     break;
                  }
                  if(param1.templateInfo.Type == 9 && inHouse)
                  {
                     _carpetSp.addChild(_loc5_);
                     _viewList.push(_loc5_);
                     break;
                  }
                  if(param3 >= 0)
                  {
                     _wallSp.addChildAt(_loc5_,param3);
                  }
                  else
                  {
                     _wallSp.addChild(_loc5_);
                  }
                  _viewList.unshift(_loc5_);
            }
         }
         model.selectFurn = null;
         if(param2)
         {
            _loc5_.selected = true;
            model.clickFurn = param1;
         }
         else
         {
            model.clickFurn = null;
         }
      }
      
      public function removeFurniture(param1:FurnitureInfo) : void
      {
         var _loc3_:FurnitureView = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         model.noFixList.push(param1);
         _loc5_ = 0;
         while(_loc5_ < model.fixUpList.length)
         {
            if(model.fixUpList[_loc5_].furnitureId == param1.furnitureId)
            {
               model.fixUpList.splice(_loc5_,1);
               break;
            }
            _loc5_++;
         }
         if(param1.templateInfo.Type == 1 && inHouse)
         {
            ObjectUtils.disposeAllChildren(_groundSp1);
            return;
         }
         if(param1.templateInfo.Type == 2 && inHouse)
         {
            ObjectUtils.disposeAllChildren(_groundSp2);
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _viewList.length)
         {
            _loc3_ = _viewList[_loc5_];
            if(_loc3_.data.furnitureId == param1.furnitureId)
            {
               _viewList.splice(_loc5_,1);
               _loc3_.dispose();
               break;
            }
            _loc5_++;
         }
         var _loc6_:FurnitureTempInfo = TempleteManager.instance.furnitureTemplateCate.getTempById(param1.templateId);
         var _loc4_:RegExp = new RegExp("_" + _loc6_.Type,"g");
         switch(int(param1.area))
         {
            case 0:
               _loc5_ = int(param1.posX);
               while(_loc5_ < param1.posX + param1.width)
               {
                  if(_loc5_ >= model.floorList.length)
                  {
                     break;
                  }
                  _loc7_ = int(param1.posY);
                  while(_loc7_ < param1.posY + param1.height)
                  {
                     if(_loc7_ >= model.floorList[_loc5_].length)
                     {
                        break;
                     }
                     _loc2_ = model.floorList[_loc5_][_loc7_];
                     _loc2_ = _loc2_.replace(_loc4_,"");
                     model.floorList[_loc5_][_loc7_] = _loc2_;
                     _loc7_++;
                  }
                  _loc5_++;
               }
               break;
            case 1:
               _loc5_ = int(param1.posX);
               while(_loc5_ < param1.posX + param1.width)
               {
                  if(_loc5_ >= model.leftList.length)
                  {
                     break;
                  }
                  _loc7_ = int(param1.posY);
                  while(_loc7_ < param1.posY + param1.height)
                  {
                     if(_loc7_ >= model.leftList[_loc5_].length)
                     {
                        break;
                     }
                     _loc2_ = model.leftList[_loc5_][_loc7_];
                     _loc2_ = _loc2_.replace(_loc4_,"");
                     model.leftList[_loc5_][_loc7_] = _loc2_;
                     _loc7_++;
                  }
                  _loc5_++;
               }
               break;
            case 2:
               _loc5_ = int(param1.posX);
               while(_loc5_ < param1.posX + param1.width)
               {
                  if(_loc5_ >= model.rightList.length)
                  {
                     break;
                  }
                  _loc7_ = int(param1.posY);
                  while(_loc7_ < param1.posY + param1.height)
                  {
                     if(_loc7_ >= model.rightList[_loc5_].length)
                     {
                        break;
                     }
                     _loc2_ = model.rightList[_loc5_][_loc7_];
                     _loc2_ = _loc2_.replace(_loc4_,"");
                     model.rightList[_loc5_][_loc7_] = _loc2_;
                     _loc7_++;
                  }
                  _loc5_++;
               }
         }
      }
      
      public function setFixState() : void
      {
         if(model.isSelf && Boolean(model.inFixUp))
         {
            drawBg();
            if(_drawLayer)
            {
               _drawLayer.graphics.clear();
            }
         }
         else
         {
            clear();
         }
      }
      
      private function drawBg() : void
      {
         var _loc1_:Point = null;
         this.graphics.clear();
         this.graphics.beginFill(16777215,0);
         this.graphics.endFill();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _renderLayer.graphics.clear();
         _renderLayer.graphics.lineStyle(2,5635925,0.9);
         _loc2_ = 0;
         while(_loc2_ <= floor)
         {
            _renderLayer.graphics.moveTo(_corner.x + _loc2_ * 60 * Math.sin(3.141592653589793 / 3),_corner.y + _loc2_ * 60 * Math.sin(3.141592653589793 / 6));
            _renderLayer.graphics.lineTo(_corner.x + (_loc2_ * 60 - floor * 60) * Math.sin(3.141592653589793 / 3),_corner.y + (_loc2_ + floor) * 60 * Math.sin(3.141592653589793 / 6));
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ <= floor)
         {
            _renderLayer.graphics.moveTo(_corner.x - _loc2_ * 60 * Math.sin(3.141592653589793 / 3),_corner.y + _loc2_ * 60 * Math.sin(3.141592653589793 / 6));
            _renderLayer.graphics.lineTo(_corner.x + (floor - _loc2_) * 60 * Math.sin(3.141592653589793 / 3),_corner.y + (_loc2_ + floor) * 60 * Math.sin(3.141592653589793 / 6));
            _loc2_++;
         }
         if(inHome)
         {
            _renderLayer.graphics.lineStyle();
            _loc2_ = 0;
            while(_loc2_ < floor)
            {
               _loc3_ = 0;
               while(_loc3_ < floor)
               {
                  if(model.floorList[_loc2_][_loc3_].indexOf("999") < 0)
                  {
                     drawCell(_renderLayer,_loc2_,_loc3_,0,true);
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(inHouse)
         {
            _loc2_ = 0;
            while(_loc2_ < wall)
            {
               _renderLayer.graphics.moveTo(_left.x,_left.y + _loc2_ * 60);
               _renderLayer.graphics.lineTo(_corner.x,_corner.y - (wall - _loc2_) * 60);
               _renderLayer.graphics.lineTo(_right.x,_right.y + _loc2_ * 60);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ <= floor)
            {
               _loc1_ = Point.interpolate(new Point(_corner.x,_corner.y - wall * 60),_left,_loc2_ / floor);
               _renderLayer.graphics.moveTo(_loc1_.x,_loc1_.y);
               _loc1_ = Point.interpolate(_corner,new Point(_left.x,_left.y + wall * 60),_loc2_ / floor);
               _renderLayer.graphics.lineTo(_loc1_.x,_loc1_.y);
               _loc2_++;
            }
            _loc2_ = 1;
            while(_loc2_ <= floor)
            {
               _loc1_ = Point.interpolate(_right,new Point(_corner.x,_corner.y - wall * 60),_loc2_ / floor);
               _renderLayer.graphics.moveTo(_loc1_.x,_loc1_.y);
               _loc1_ = Point.interpolate(new Point(_right.x,_right.y + wall * 60),_corner,_loc2_ / floor);
               _renderLayer.graphics.lineTo(_loc1_.x,_loc1_.y);
               _loc2_++;
            }
         }
      }
      
      private function clear() : void
      {
         this.graphics.clear();
         if(_renderLayer)
         {
            _renderLayer.graphics.clear();
         }
         if(_drawLayer)
         {
            _drawLayer.graphics.clear();
         }
      }
      
      public function onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc7_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(model.inFixUp == false)
         {
            _loc5_ = 0;
            while(_loc5_ < _viewList.length)
            {
               if(_viewList[_loc5_].getClickEvent(param1))
               {
                  break;
               }
               _loc5_++;
            }
         }
         else
         {
            if(param1.target is IconButton)
            {
               return;
            }
            _drawLayer.graphics.clear();
            _loc3_ = false;
            _loc5_ = 0;
            while(_loc5_ < _viewList.length)
            {
               if(_loc3_)
               {
                  _viewList[_loc5_].selected = false;
               }
               else if(_viewList[_loc5_].mouseClickHandler(param1))
               {
                  _loc3_ = true;
               }
               _loc5_++;
            }
            if(_loc3_)
            {
               return;
            }
            if(model.selectFurn && model.selectFurn.posX >= 0 && model.selectFurn.posY >= 0)
            {
               if(inHouse)
               {
                  _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(model.selfInfo.houseLv,45);
               }
               else if(inHome)
               {
                  _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(model.selfInfo.homeLv,46);
               }
               if(_loc4_)
               {
                  _loc7_ = _loc4_.TemplateName.split(",");
                  _loc2_ = 0;
                  _loc6_ = 0;
                  while(_loc6_ < model.fixUpList.length)
                  {
                     if(model.fixUpList[_loc6_].templateInfo.FurnitureType == selectTemp.FurnitureType)
                     {
                        _loc2_++;
                     }
                     _loc6_++;
                  }
                  if(parseInt(_loc7_[selectTemp.FurnitureType - 1]) <= _loc2_)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.house.FurnitureLayer.numLimit1"));
                     return;
                  }
                  if(testFurniture(model.selectFurn))
                  {
                     FurnitureSortHelper.dealWith(model.fixUpList,addFurniture,model.selectFurn);
                     MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
                  }
               }
            }
            else
            {
               model.selectFurn = null;
               model.clickFurn = null;
            }
         }
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(model.inFixUp == false || selectTemp == null)
         {
            return;
         }
         setMouseXY();
         if(model.selectFurn)
         {
            if(model.selectFurn.posX != _mP.x || model.selectFurn.posY != _mP.y)
            {
               model.selectFurn.posX = _mP.x;
               model.selectFurn.posY = _mP.y;
               _drawLayer.graphics.clear();
               draw();
               _loc2_ = new Point();
               if(model.selectFurn.posX > 0 && model.selectFurn.posY > 0)
               {
                  if(model.selectFurn.area == 0)
                  {
                     _loc2_.x = _corner.x + (model.selectFurn.posX - model.selectFurn.posY) * 60 * Math.sin(3.141592653589793 / 3);
                     _loc2_.y = _corner.y + (model.selectFurn.posX + model.selectFurn.posY) * 60 * Math.sin(3.141592653589793 / 6);
                  }
                  else if(model.selectFurn.area == 1)
                  {
                     _loc2_.x = _left.x + model.selectFurn.posX * 60 * Math.sin(3.141592653589793 / 3);
                     _loc2_.y = _left.y + model.selectFurn.posY * 60 - model.selectFurn.posX * 60 * Math.sin(3.141592653589793 / 6);
                  }
                  else if(model.selectFurn.area == 2)
                  {
                     _loc2_.x = _corner.x + model.selectFurn.posX * 60 * Math.sin(3.141592653589793 / 3);
                     _loc2_.y = _corner.y - wall * 60 + model.selectFurn.posY * 60 + model.selectFurn.posX * 60 * Math.sin(3.141592653589793 / 6);
                  }
                  model.selectFurn.x = this.localToGlobal(_loc2_).x;
                  model.selectFurn.y = this.localToGlobal(_loc2_).y;
               }
               else
               {
                  model.selectFurn.x = StageReferance.stage.mouseX;
                  model.selectFurn.y = StageReferance.stage.mouseY;
               }
            }
            else if(_mP.x == -1 || _mP.y == -1)
            {
               model.selectFurn.x = StageReferance.stage.mouseX;
               model.selectFurn.y = StageReferance.stage.mouseY;
               _drawLayer.graphics.clear();
            }
         }
         else
         {
            _drawLayer.graphics.clear();
         }
      }
      
      private function setMouseXY() : void
      {
         _mP.x = -1;
         _mP.y = -1;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Point = new Point();
         if(isInFloor(_corner,floor * 60))
         {
            _loc2_ = 0;
            while(_loc2_ < floor)
            {
               if(_mP.x >= 0 && _mP.y >= 0)
               {
                  break;
               }
               _loc3_ = 0;
               while(_loc3_ < floor)
               {
                  _loc1_.x = _corner.x + _loc3_ * 60 * Math.sin(3.141592653589793 / 3) - _loc2_ * 60 * Math.sin(3.141592653589793 / 3);
                  _loc1_.y = _corner.y + _loc3_ * 60 * Math.sin(3.141592653589793 / 6) + _loc2_ * 60 * Math.sin(3.141592653589793 / 6);
                  if(isInFloor(_loc1_,60))
                  {
                     _mP.x = _loc3_;
                     _mP.y = _loc2_;
                     break;
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         if(inHouse)
         {
            if(isInLeftWall(_left,floor * 60,wall * 60))
            {
               _loc2_ = 0;
               while(_loc2_ < wall)
               {
                  if(_mP.x >= 0 && _mP.y >= 0)
                  {
                     break;
                  }
                  _loc3_ = 0;
                  while(_loc3_ < floor)
                  {
                     _loc1_.x = _left.x + _loc3_ * 60 * Math.sin(3.141592653589793 / 3);
                     _loc1_.y = _left.y + _loc2_ * 60 - _loc3_ * 60 * Math.sin(3.141592653589793 / 6);
                     if(isInLeftWall(_loc1_,60,60))
                     {
                        _mP.x = _loc3_;
                        _mP.y = _loc2_;
                        break;
                     }
                     _loc3_++;
                  }
                  _loc2_++;
               }
            }
            _loc1_.x = _corner.x;
            _loc1_.y = _corner.y - wall * 60;
            if(isInRightWall(_loc1_,floor * 60,wall * 60))
            {
               _loc2_ = 0;
               while(_loc2_ < wall)
               {
                  if(_mP.x >= 0 && _mP.y >= 0)
                  {
                     break;
                  }
                  _loc3_ = 0;
                  while(_loc3_ < floor)
                  {
                     _loc1_.x = _corner.x + _loc3_ * 60 * Math.sin(3.141592653589793 / 3);
                     _loc1_.y = _corner.y - wall * 60 + _loc2_ * 60 + _loc3_ * 60 * Math.sin(3.141592653589793 / 6);
                     if(isInRightWall(_loc1_,60,60))
                     {
                        _mP.x = _loc3_;
                        _mP.y = _loc2_;
                        break;
                     }
                     _loc3_++;
                  }
                  _loc2_++;
               }
            }
         }
      }
      
      private function isInFloor(param1:Point, param2:int) : Boolean
      {
         if(param1 == null || param2 <= 0 || model.selectFurn.area != 0)
         {
            return false;
         }
         var _loc3_:Number = param1.y + Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6);
         var _loc4_:Number = param1.y + 2 * param2 * Math.sin(3.141592653589793 / 6) - Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6);
         if(this.mouseY >= param1.y && this.mouseY <= param1.y + 2 * param2 * Math.sin(3.141592653589793 / 6) && this.mouseY >= _loc3_ && this.mouseY <= _loc4_)
         {
            return true;
         }
         return false;
      }
      
      private function isInLeftWall(param1:Point, param2:int, param3:int) : Boolean
      {
         if(param1 == null || param2 <= 0 || param3 <= 0 || model.selectFurn.area == 0)
         {
            return false;
         }
         var _loc4_:Number = param1.y - Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6);
         var _loc5_:Number = param1.y - Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6) + param3;
         if(this.mouseX >= param1.x && this.mouseX <= param1.x + param2 * Math.sin(3.141592653589793 / 3) && this.mouseY >= _loc4_ && this.mouseY <= _loc5_)
         {
            if(model.selectFurn.area != 1)
            {
               model.selectFurn.setRotation();
               model.selectFurn = model.selectFurn;
            }
            if(model.selectFurn.area != 1)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function isInRightWall(param1:Point, param2:int, param3:int) : Boolean
      {
         if(param1 == null || param2 <= 0 || param3 <= 0 || model.selectFurn.area == 0)
         {
            return false;
         }
         var _loc4_:Number = param1.y + Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6);
         var _loc5_:Number = param1.y + Math.abs(this.mouseX - param1.x) * Math.tan(3.141592653589793 / 6) + param3;
         if(this.mouseX >= param1.x && this.mouseX <= param1.x + param2 * Math.sin(3.141592653589793 / 3) && this.mouseY >= _loc4_ && this.mouseY <= _loc5_)
         {
            if(model.selectFurn.area != 2)
            {
               model.selectFurn.setRotation();
               model.selectFurn = model.selectFurn;
            }
            if(model.selectFurn.area != 2)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      private function draw() : void
      {
         if(selectTemp == null || _mP.x < 0 || _mP.y < 0)
         {
            return;
         }
         var _loc1_:String = selectTemp["Icon" + selectFurniture.rotation];
         if(StringHelper.isNullOrEmpty(_loc1_))
         {
            return;
         }
         var _loc2_:Array = _loc1_.split(",");
         if(_loc2_.length != 3)
         {
            return;
         }
         var _loc3_:Point = new Point();
         if(model.selectFurn.area == 0)
         {
            if(_mP.x + int(_loc2_[1]) > floor)
            {
               _loc3_.x = floor - int(_loc2_[1]);
               selectFurniture.posX = _loc3_.x;
               if(_mP.y + int(_loc2_[2]) > floor)
               {
                  _loc3_.y = floor - int(_loc2_[2]);
                  selectFurniture.posY = _loc3_.y;
               }
               else
               {
                  _loc3_.y = _mP.y;
               }
            }
            else
            {
               if(_mP.y + int(_loc2_[2]) > floor)
               {
                  _loc3_.y = floor - int(_loc2_[2]);
                  selectFurniture.posY = _loc3_.y;
               }
               else
               {
                  _loc3_.y = _mP.y;
               }
               _loc3_.x = _mP.x;
            }
            drawByRowAndCol(_loc3_,int(_loc2_[1]),int(_loc2_[2]),0);
         }
         else if(model.selectFurn.area == 1 || model.selectFurn.area == 2)
         {
            if(_mP.x + int(_loc2_[1]) > floor)
            {
               _loc3_.x = floor - int(_loc2_[1]);
               selectFurniture.posX = _loc3_.x;
               if(_mP.y + int(_loc2_[2]) > wall)
               {
                  _loc3_.y = wall - int(_loc2_[2]);
                  selectFurniture.posY = _loc3_.y;
               }
               else
               {
                  _loc3_.y = _mP.y;
               }
            }
            else
            {
               if(_mP.y + int(_loc2_[2]) > wall)
               {
                  _loc3_.y = wall - int(_loc2_[2]);
                  selectFurniture.posY = _loc3_.y;
               }
               else
               {
                  _loc3_.y = _mP.y;
               }
               _loc3_.x = _mP.x;
            }
            drawByRowAndCol(_loc3_,int(_loc2_[1]),int(_loc2_[2]),model.selectFurn.area);
         }
      }
      
      private function drawByRowAndCol(param1:Point, param2:int, param3:int, param4:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<Point> = new Vector.<Point>();
         _loc5_ = param1.x;
         while(_loc5_ < param1.x + param2)
         {
            _loc6_ = param1.y;
            while(_loc6_ < param1.y + param3)
            {
               _loc7_.push(new Point(_loc5_,_loc6_));
               _loc6_++;
            }
            _loc5_++;
         }
         drawCellList(_loc7_,param4);
      }
      
      private function drawCellList(param1:Vector.<Point>, param2:int = 0) : void
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         if(selectTemp == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            loop5:
            switch(int(selectFurniture.area))
            {
               case 0:
                  _loc3_ = model.floorList[param1[_loc6_].x][param1[_loc6_].y].split("_");
                  if(inHome)
                  {
                     if(_loc3_.indexOf("999") < 0 || _loc3_.indexOf("1") > 0 || _loc3_.indexOf("2") > 0 || _loc3_.indexOf("3") > 0 || _loc3_.indexOf("4") > 0 || _loc3_.indexOf("5") > 0 || _loc3_.indexOf("6") > 0)
                     {
                        selectFurniture.posX = selectFurniture.posY = -1;
                        _mP.x = _mP.y = -1;
                        _loc4_ = true;
                     }
                     else if(selectFurniture.templateInfo.FurnitureType == 3)
                     {
                        if((param1[_loc6_].x >= 23 && param1[_loc6_].x <= 37 && param1[_loc6_].y >= 29) == false)
                        {
                           selectFurniture.posX = selectFurniture.posY = -1;
                           _mP.x = _mP.y = -1;
                           _loc4_ = true;
                        }
                     }
                     else if(param1[_loc6_].x >= 23 && param1[_loc6_].x <= 37 && param1[_loc6_].y >= 29)
                     {
                        selectFurniture.posX = selectFurniture.posY = -1;
                        _mP.x = _mP.y = -1;
                        _loc4_ = true;
                     }
                  }
                  else if(inHouse)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _loc3_.length)
                     {
                        if(model.filterType(int(_loc3_[_loc5_]),selectTemp.Type) == false)
                        {
                           selectFurniture.posX = selectFurniture.posY = -1;
                           _mP.x = _mP.y = -1;
                           _loc4_ = true;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  break;
               case 1:
                  _loc3_ = model.leftList[param1[_loc6_].x][param1[_loc6_].y].split("_");
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_.length)
                  {
                     if(model.filterType(int(_loc3_[_loc5_]),selectTemp.Type) == false)
                     {
                        selectFurniture.posX = selectFurniture.posY = -1;
                        _mP.x = _mP.y = -1;
                        _loc4_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  break;
               case 2:
                  _loc3_ = model.rightList[param1[_loc6_].x][param1[_loc6_].y].split("_");
                  _loc5_ = 0;
                  while(true)
                  {
                     if(_loc5_ >= _loc3_.length)
                     {
                        break loop5;
                     }
                     if(model.filterType(int(_loc3_[_loc5_]),selectTemp.Type) == false)
                     {
                        break;
                     }
                     _loc5_++;
                  }
                  selectFurniture.posX = selectFurniture.posY = -1;
                  _mP.x = _mP.y = -1;
                  _loc4_ = true;
            }
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            drawCell(_drawLayer,param1[_loc5_].x,param1[_loc5_].y,param2,_loc4_);
            _loc5_++;
         }
         param1.splice(0,param1.length);
      }
      
      private function drawCell(param1:Sprite, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = true) : void
      {
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:int = param2 * 60;
         var _loc12_:int = param3 * 60;
         var _loc11_:int = 0;
         _mat.tx = _corner.x + (_loc6_ - _loc12_) * Math.sin(3.141592653589793 / 3) - 52;
         _mat.ty = _corner.y + (_loc6_ + _loc12_) * Math.sin(3.141592653589793 / 6);
         if(param5)
         {
            if(param4 == 0)
            {
               param1.graphics.beginBitmapFill(_redBmd,_mat);
            }
            else
            {
               param1.graphics.lineStyle(1,16733525,0.5);
            }
         }
         else if(param4 == 0)
         {
            param1.graphics.beginBitmapFill(_greenBmd,_mat);
         }
         else
         {
            param1.graphics.lineStyle(1,5635925,0.5);
         }
         if(param4 == 0)
         {
            param1.graphics.drawRect(_mat.tx,_mat.ty,104,60);
         }
         else if(param4 == 1)
         {
            _loc11_ = 0;
            while(_loc11_ <= 60)
            {
               _loc8_ = _left.x + (_loc6_ + _loc11_) * Math.sin(3.141592653589793 / 3);
               _loc7_ = _left.y + _loc12_ - (_loc6_ + _loc11_) * Math.sin(3.141592653589793 / 6);
               _loc9_ = _loc7_ + 60;
               param1.graphics.moveTo(_loc8_,_loc7_);
               param1.graphics.lineTo(_loc8_,_loc9_);
               _loc11_++;
            }
         }
         else if(param4 == 2)
         {
            _loc11_ = 0;
            while(_loc11_ <= 60)
            {
               _loc8_ = _corner.x + (_loc6_ + _loc11_) * Math.sin(3.141592653589793 / 3);
               _loc7_ = _corner.y - wall * 60 + _loc12_ + (_loc6_ + _loc11_) * Math.sin(3.141592653589793 / 6);
               _loc9_ = _loc7_ + 60;
               param1.graphics.moveTo(_loc8_,_loc7_);
               param1.graphics.lineTo(_loc8_,_loc9_);
               _loc11_++;
            }
         }
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      private function get selectFurniture() : FurnitureInfo
      {
         return HomeManager.instance.model.selectFurn;
      }
      
      private function get selectTemp() : FurnitureTempInfo
      {
         if(selectFurniture == null)
         {
            return null;
         }
         var _loc1_:int = int(selectFurniture.templateId);
         return TempleteManager.instance.furnitureTemplateCate.getTempById(_loc1_);
      }
      
      public function setFindPathData() : void
      {
         var _loc6_:Point = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(inHouse == false && inHome == false)
         {
            return;
         }
         var _loc1_:Vector.<Point> = new Vector.<Point>();
         _loc4_ = 0;
         while(_loc4_ < floor)
         {
            _loc5_ = 0;
            while(_loc5_ < floor)
            {
               if(inHouse && !FarmManager.instance.model.bigBonFireIsOpen)
               {
                  if(model.floorList[_loc4_][_loc5_].indexOf("7") > 0 || model.floorList[_loc4_][_loc5_].indexOf("8") > 0)
                  {
                     _loc2_ = Math.floor((_corner.x + (_loc4_ - _loc5_) * 60 * Math.sin(3.141592653589793 / 3)) / 20);
                     _loc3_ = Math.floor((_corner.y + (_loc4_ + _loc5_) * 60 * Math.sin(3.141592653589793 / 6)) / 20);
                     _loc6_ = new Point(_loc2_,_loc3_);
                     _loc1_.push(_loc6_);
                  }
               }
               else if(inHome)
               {
                  if(model.floorList[_loc4_][_loc5_].indexOf("1") > 0 || model.floorList[_loc4_][_loc5_].indexOf("2") > 0 || model.floorList[_loc4_][_loc5_].indexOf("3") > 0 || model.floorList[_loc4_][_loc5_].indexOf("4") > 0 || model.floorList[_loc4_][_loc5_].indexOf("5") > 0 || model.floorList[_loc4_][_loc5_].indexOf("6") > 0)
                  {
                     _loc2_ = Math.floor((_corner.x + (_loc4_ - _loc5_) * 60 * Math.sin(3.141592653589793 / 3)) / 20);
                     _loc3_ = Math.floor((_corner.y + (_loc4_ + _loc5_) * 60 * Math.sin(3.141592653589793 / 6)) / 20);
                     _loc6_ = new Point(_loc2_,_loc3_);
                     _loc1_.push(_loc6_);
                  }
               }
               _loc5_++;
            }
            _loc4_++;
         }
         var _loc8_:Dictionary = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc4_].x - 2;
            while(_loc5_ <= _loc1_[_loc4_].x + 2)
            {
               _loc7_ = _loc1_[_loc4_].y;
               while(_loc7_ < _loc1_[_loc4_].y + 3)
               {
                  _loc8_[_loc5_ + "_" + _loc7_] = 1;
                  _loc7_++;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         mapController.findPath.refreshData(_loc8_);
      }
      
      private function get mapController() : CampaignMapController
      {
         return CampaignManager.instance.controller as CampaignMapController;
      }
      
      public function dispose() : void
      {
         cleanList();
         this.graphics.clear();
         if(_renderLayer)
         {
            _renderLayer.graphics.clear();
         }
         _renderLayer = null;
         if(_drawLayer)
         {
            _drawLayer.graphics.clear();
         }
         _drawLayer = null;
         ObjectUtils.disposeAllChildren(_groundSp1);
         _groundSp1 = null;
         ObjectUtils.disposeAllChildren(_groundSp2);
         _groundSp2 = null;
         if(_greenBmd)
         {
            _greenBmd.dispose();
         }
         _greenBmd = null;
         if(_redBmd)
         {
            _redBmd.dispose();
         }
         _redBmd = null;
         _carpetSp = null;
         _wallSp = null;
         _floorSp = null;
         _btnSp = null;
         _corner = null;
         _mP = null;
         _viewList = null;
         _mat = null;
      }
      
      private function cleanList() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(_viewList)
         {
            while(_viewList.length > 0)
            {
               _viewList.pop().dispose();
            }
         }
         model.floorList = [];
         model.leftList = [];
         model.rightList = [];
         _loc2_ = 0;
         while(_loc2_ < floor)
         {
            model.floorList.push([]);
            _loc4_ = 0;
            while(_loc4_ < floor)
            {
               model.floorList[_loc2_].push("0");
               _loc1_ = Math.floor((_corner.x + (_loc2_ - _loc4_) * 60 * Math.sin(3.141592653589793 / 3)) / 20) - 1;
               _loc3_ = Math.floor((_corner.y + (_loc2_ + _loc4_) * 60 * Math.sin(3.141592653589793 / 6)) / 20) + 1;
               if(inHome && Boolean(mapController.findPath.canFix(_loc1_,_loc3_)))
               {
                  model.floorList[_loc2_][_loc4_] = "0_999";
               }
               _loc4_++;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < floor)
         {
            model.leftList.push([]);
            _loc4_ = 0;
            while(_loc4_ < wall)
            {
               model.leftList[_loc2_].push("0");
               _loc4_++;
            }
            model.rightList.push([]);
            _loc4_ = 0;
            while(_loc4_ < wall)
            {
               model.rightList[_loc2_].push("0");
               _loc4_++;
            }
            _loc2_++;
         }
      }
   }
}

