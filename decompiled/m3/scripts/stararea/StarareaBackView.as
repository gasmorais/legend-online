package stararea
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import managers.FashionManager;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import mvc.module.stararea.event.StarareaEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StarareaRoadsTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   
   public class StarareaBackView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _mapMc:MovieClip;
      
      private var nodes:HashMap;
      
      private var roadNodeList:HashMap;
      
      private var spRoads:Sprite;
      
      private const lineStartX:int = 570;
      
      private const lineStartY:int = 444;
      
      private var lineBg:Sprite;
      
      private var _figure1:ShowAvatar;
      
      private var _figure2:ShowAvatar;
      
      private var _figure3:ShowAvatar;
      
      private var _figure4:ShowAvatar;
      
      private var _fContainer1:Component;
      
      private var _fContainer2:Component;
      
      private var _fContainer3:Component;
      
      private var _fContainer4:Component;
      
      private var _showThane:ThaneInfo;
      
      private var currentThane:ThaneInfo;
      
      private var s:Boolean = true;
      
      public function StarareaBackView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.stararea.bg");
         _mapMc = ComponentFactory.Instance.creatCustomObject("asset.stararea.mc.line");
         _mapMc.x = 570;
         _mapMc.y = 444;
         addChild(_bg);
         addChild(_mapMc);
         lineBg = new Sprite();
         lineBg.filters = [new GlowFilter(16777215,0.3,15,15,5)];
         addChild(lineBg);
         roadNodeList = new HashMap();
         initNodes();
         spRoads = new Sprite();
         addChild(spRoads);
         updateNodes();
         updateRoads();
         showFigure();
      }
      
      private function initEvent() : void
      {
         StarareaManager.instance.addEventListener("UPDATE_NODES",updateNodes);
         StarareaManager.instance.addEventListener("UPDATE_ROADS",updateRoads);
         StageReferance.stage.addEventListener("keyDown",onKeyDown);
         NotificationManager.instance.addEventListener("event.stararea.light",isLightHandler);
         NotificationManager.instance.addEventListener("event.stararea.key",isKeyHandler);
      }
      
      private function removeEvent() : void
      {
         StarareaManager.instance.removeEventListener("UPDATE_NODES",updateNodes);
         StarareaManager.instance.removeEventListener("UPDATE_ROADS",updateRoads);
         StageReferance.stage.removeEventListener("keyDown",onKeyDown);
         NotificationManager.instance.removeEventListener("event.stararea.light",isLightHandler);
         NotificationManager.instance.removeEventListener("event.stararea.key",isKeyHandler);
      }
      
      private function isLightHandler(param1:NotificationEvent) : void
      {
         var _loc6_:StarareaPointItem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Boolean = Boolean(param1.data);
         var _loc5_:Array = nodes.keySet;
         var _loc2_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc7_ = int(_loc5_[_loc4_]);
            _loc8_ = int(model.nodes[_loc7_ - 1]);
            if(_loc8_ >= 100)
            {
               _loc6_ = nodes.getValue(_loc7_) as StarareaPointItem;
               if(_loc6_ != null)
               {
                  _loc6_.isLight = _loc3_;
               }
            }
            _loc4_++;
         }
      }
      
      private function isKeyHandler(param1:NotificationEvent) : void
      {
         var _loc3_:StarareaEventItem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Boolean = Boolean(param1.data);
         var _loc6_:Array = roadNodeList.keySet;
         var _loc2_:int = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc7_ = int(_loc6_[_loc5_]);
            _loc8_ = int(model.roads[_loc7_]);
            if(_loc8_ == 2)
            {
               _loc3_ = roadNodeList.getValue(_loc7_) as StarareaEventItem;
               if(_loc3_ != null)
               {
                  _loc3_.isLight = _loc4_;
               }
            }
            _loc5_++;
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(!param1.ctrlKey)
         {
            return;
         }
         if(param1.keyCode == 32)
         {
            if(s)
            {
               lineBg.graphics.clear();
            }
            else
            {
               updateRoads();
            }
            s = !s;
         }
         else if(param1.keyCode == 37)
         {
            lineBg.x -= 10;
         }
         else if(param1.keyCode == 38)
         {
            lineBg.y -= 10;
         }
         else if(param1.keyCode == 39)
         {
            lineBg.x += 10;
         }
         else if(param1.keyCode == 40)
         {
            lineBg.y += 10;
         }
      }
      
      private function updateRoads(param1:StarareaEvent = null) : void
      {
         var _loc7_:StarareaPointItem = null;
         var _loc8_:StarareaPointItem = null;
         var _loc2_:StarareaRoadsTemplate = null;
         var _loc3_:StarareaEventItem = null;
         var _loc4_:StarareaEventItem = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         lineBg.graphics.clear();
         _loc5_ = 0;
         while(_loc5_ < model.roads.length)
         {
            _loc6_ = int(model.roads[_loc5_]);
            _loc2_ = TempleteManager.instance.starareaRoadsTempCate.getTempleteById(_loc5_ + 1);
            _loc7_ = nodes.getValue(_loc2_.Node1) as StarareaPointItem;
            _loc8_ = nodes.getValue(_loc2_.Node2) as StarareaPointItem;
            if(_loc7_.type == -1 || _loc8_.type == -1)
            {
               if(_loc6_ != 0)
               {
                  _loc3_ = roadNodeList.getValue(_loc5_) as StarareaEventItem;
                  if(_loc3_ == null)
                  {
                     _loc3_ = new StarareaEventItem();
                     _loc3_.initParam(_loc2_,_loc6_);
                     spRoads.addChild(_loc3_);
                     roadNodeList.put(_loc5_,_loc3_);
                     _loc3_.x = (_loc7_.x + _loc8_.x) / 2;
                     _loc3_.y = (_loc7_.y + _loc8_.y) / 2;
                  }
                  lineBg.graphics.lineStyle(5,0,0.7);
                  lineBg.graphics.moveTo(_loc7_.x,_loc7_.y);
                  lineBg.graphics.lineTo(_loc8_.x,_loc8_.y);
               }
               else
               {
                  lineBg.graphics.lineStyle(5,8896510,0.7);
                  lineBg.graphics.moveTo(_loc7_.x,_loc7_.y);
                  lineBg.graphics.lineTo(_loc8_.x,_loc8_.y);
                  _loc4_ = roadNodeList.getValue(_loc5_) as StarareaEventItem;
                  if(_loc4_ != null)
                  {
                     ObjectUtils.disposeObject(_loc4_);
                     roadNodeList.remove(_loc5_);
                  }
               }
            }
            else
            {
               lineBg.graphics.lineStyle(5,0,0.7);
               lineBg.graphics.moveTo(_loc7_.x,_loc7_.y);
               lineBg.graphics.lineTo(_loc8_.x,_loc8_.y);
            }
            _loc5_++;
         }
         model.isInit = true;
         model.isKey = false;
         model.isLight = false;
      }
      
      private function updateNodes(param1:StarareaEvent = null) : void
      {
         var _loc3_:StarareaPointItem = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < model.nodes.length)
         {
            _loc3_ = nodes.getValue(_loc2_ + 1) as StarareaPointItem;
            _loc4_ = int(model.nodes[_loc2_]);
            if(_loc4_ >= 100)
            {
               _loc3_.isInFrog = true;
            }
            else
            {
               _loc3_.isInFrog = false;
            }
            _loc3_.type = _loc4_;
            addChild(_loc3_);
            if(model.pointFlashArr[_loc2_ + 1] == null)
            {
               model.pointFlashArr[_loc2_ + 1] = 1;
            }
            _loc2_++;
         }
         model.isKey = false;
         model.isLight = false;
      }
      
      private function initNodes() : void
      {
         var _loc2_:StarareaPointItem = null;
         var _loc1_:DisplayObject = null;
         nodes = new HashMap();
         while(_mapMc.numChildren > 0)
         {
            _loc1_ = _mapMc.getChildAt(0) as DisplayObject;
            if(_loc1_ && _loc1_.name.indexOf("star") >= 0)
            {
               _loc2_ = new StarareaPointItem(_loc1_ as MovieClip,570,444);
               nodes.put(_loc1_.name.slice(4),_loc2_);
               1;
               addChild(_loc2_);
            }
            else
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
      }
      
      private function showFigure() : void
      {
         var _loc1_:Point = null;
         _fContainer1 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer2 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer3 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         _fContainer4 = ComponentFactory.Instance.creatCustomObject("SevenYearStararea.fashionContainer");
         addChild(_fContainer1);
         addChild(_fContainer2);
         addChild(_fContainer3);
         addChild(_fContainer4);
         _figure1 = new ShowAvatar(true);
         _figure2 = new ShowAvatar(true);
         _figure3 = new ShowAvatar(true);
         _figure4 = new ShowAvatar(true);
         _fContainer1.addChild(_figure1);
         _fContainer2.addChild(_figure2);
         _fContainer3.addChild(_figure3);
         _fContainer4.addChild(_figure4);
         _figure1.scaleX = _figure1.scaleY = 0.5;
         _figure2.scaleX = _figure2.scaleY = 0.5;
         _figure3.scaleX = _figure3.scaleY = 0.5;
         _figure4.scaleX = _figure4.scaleY = 0.5;
         var _loc2_:int = 150;
         _loc1_ = StarareaManager.instance.model.getStarPosById(StarareaModel.BIG_BOX_ARRAY[0]);
         _fContainer1.x = _loc1_.x - 70;
         _fContainer1.y = _loc1_.y - 130 - 50;
         _loc1_ = StarareaManager.instance.model.getStarPosById(StarareaModel.BIG_BOX_ARRAY[1]);
         _fContainer2.x = _loc1_.x - 70 - _loc2_ + 140;
         _fContainer2.y = _loc1_.y - 130 - 50;
         _loc1_ = StarareaManager.instance.model.getStarPosById(StarareaModel.BIG_BOX_ARRAY[2]);
         _fContainer3.x = _loc1_.x - 70 + _loc2_ - 270;
         _fContainer3.y = _loc1_.y - 130;
         _loc1_ = StarareaManager.instance.model.getStarPosById(StarareaModel.BIG_BOX_ARRAY[3]);
         _fContainer4.x = _loc1_.x - 70 + 80;
         _fContainer4.y = _loc1_.y - 130;
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[0]),_fContainer1);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[1]),_fContainer2);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[2]),_fContainer3);
         handleFashion(StarareaManager.instance.model.getNodeFashion(StarareaModel.BIG_BOX_ARRAY[3]),_fContainer4);
      }
      
      private function handleFashion(param1:Array, param2:Component) : void
      {
         var _loc6_:* = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:ShowAvatar = param2.getChildAt(0) as ShowAvatar;
         var _loc7_:GoodsTemplateInfo = param1[0];
         if(_loc7_.isViceEquip)
         {
            currentThane = ArmyManager.instance.vice;
         }
         else
         {
            currentThane = ArmyManager.instance.thane;
         }
         _showThane = new ThaneInfo();
         _showThane.templateId = currentThane.templateId;
         var _loc4_:Array = [];
         for each(_loc7_ in param1)
         {
            switch(int(_loc7_.SonType) - 109)
            {
               case 0:
                  _showThane.wingAvata = _loc7_.Avata;
                  break;
               case 1:
                  _showThane.hairFashionAvata = _loc7_.Avata;
                  break;
               case 2:
                  _showThane.armsFashionAvata = _loc7_.Avata;
                  break;
               case 3:
                  _showThane.bodyFashionAvata = _loc7_.Avata;
            }
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc7_.TemplateId;
            _loc5_.identityed = FashionManager.instance.fashionModel.hasIdentityedBook(_loc7_.TemplateId);
            _loc4_.push(_loc5_);
         }
         param2.tipData = _loc4_;
         _loc3_.data = _showThane;
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:StarareaPointItem in nodes.valueSet)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         nodes.clear();
         nodes = null;
         ObjectUtils.disposeAllChildren(spRoads);
         roadNodeList.clear();
         roadNodeList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mapMc);
         _mapMc = null;
         ObjectUtils.disposeObject(spRoads);
         spRoads = null;
         ObjectUtils.disposeObject(lineBg);
         lineBg = null;
         ObjectUtils.disposeObject(_figure1);
         _figure1 = null;
         ObjectUtils.disposeObject(_figure2);
         _figure2 = null;
         ObjectUtils.disposeObject(_figure3);
         _figure3 = null;
         ObjectUtils.disposeObject(_figure4);
         _figure4 = null;
         ObjectUtils.disposeObject(_fContainer1);
         _fContainer1 = null;
         ObjectUtils.disposeObject(_fContainer2);
         _fContainer2 = null;
         ObjectUtils.disposeObject(_fContainer3);
         _fContainer3 = null;
         ObjectUtils.disposeObject(_fContainer4);
         _fContainer4 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

