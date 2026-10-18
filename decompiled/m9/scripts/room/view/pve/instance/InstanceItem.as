package room.view.pve.instance
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.PathManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   
   public class InstanceItem extends Sprite implements Disposeable
   {
      
      public static const ITEM_CLICK:String = "instance_click";
      
      private var _areaInfo:CampaignAreaInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _closeFont:Bitmap;
      
      private var _selectBit:Bitmap;
      
      private var _instanceSp:Sprite;
      
      private var _areaNameTxt:GradientText;
      
      private var _selected:Boolean;
      
      private var _alertGrades:FilterFrameText;
      
      private var _mapIcon:BaseIconView;
      
      private var _hbox:HBox;
      
      private var gradeTextARR:Array;
      
      private var difficutlyCount:int = -1;
      
      private var _dungeonId:int;
      
      private var _isShineNow:Boolean = false;
      
      public function InstanceItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _instanceSp = ComponentFactory.Instance.creatCustomObject("room.instanceSp");
         _bg = ComponentFactory.Instance.creatComponentByStylename("room.InstanceItemBG");
         _closeFont = ComponentFactory.Instance.creatBitmap("asset.room.InstanceFontI");
         _selectBit = ComponentFactory.Instance.creatBitmap("asset.room.InstanceItemSelectImg");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.InstanceItemNameTxt");
         _alertGrades = ComponentFactory.Instance.creatComponentByStylename("room.InstanceItem.alertGrades");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("room.InstanceMapIcon");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("room.InstanceItem.hbox");
         _bg.setFrame(1);
         _instanceSp.addChild(_mapIcon);
         addChild(_bg);
         addChild(_closeFont);
         addChild(_instanceSp);
         addChild(_areaNameTxt);
         addChild(_alertGrades);
         addChild(_selectBit);
         addChild(_hbox);
         gradeTextARR = LanguageMgr.GetTranslation("room.InstanceItem.gradeText").split("|");
         selected = false;
      }
      
      private function initEvents() : void
      {
         buttonMode = true;
         addEventListener("click",__itemClick);
         addEventListener("mouseOver",__itemOver);
         addEventListener("mouseOut",__ItemOut);
      }
      
      private function removeEvents() : void
      {
         buttonMode = false;
         removeEventListener("click",__itemClick);
         removeEventListener("mouseOver",__itemOver);
         removeEventListener("mouseOut",__ItemOut);
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         stopShine();
         dispatchEvent(new Event("instance_click"));
      }
      
      private function __itemOver(param1:MouseEvent) : void
      {
         if(!_selected && !_isShineNow)
         {
            _selectBit.visible = true;
         }
      }
      
      private function __ItemOut(param1:MouseEvent) : void
      {
         if(!_selected && !_isShineNow)
         {
            _selectBit.visible = false;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectBit.visible = param1;
      }
      
      public function set dungeonId(param1:int) : void
      {
         _dungeonId = param1;
      }
      
      public function set areaInfo(param1:CampaignAreaInfo) : void
      {
         if(_hbox)
         {
            _hbox.removeAllChild();
         }
         if(param1)
         {
            _areaInfo = param1;
            difficutlyCount = _areaInfo.getMapList().length;
            if(_dungeonId == 0)
            {
               setGradeImageAndText();
            }
            _mapIcon.visible = true;
            _mapIcon.icon = PathManager.mapInstanceSmallIconPath(_areaInfo.areaId);
            _bg.setFrame(1);
            _areaNameTxt.text = _areaInfo.areaName;
            if(_areaInfo.getMapByDifficult(1).NeedFourTransfer)
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text6") + ")";
            }
            else if(_areaInfo.getMapByDifficult(1).NeedThirdTransfer)
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text5") + ")";
            }
            else if(_areaInfo.getMapByDifficult(1).NeedChangeJob)
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text4") + ")";
            }
            else if(_areaInfo.getMapByDifficult(1).NeedTransfer)
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text1") + ")";
            }
            else if(_areaInfo.getMapByDifficult(1).MinLevel == 80)
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text3",_areaInfo.getMapByDifficult(1).MinLevel) + ")";
            }
            else
            {
               _alertGrades.text = "(" + LanguageMgr.GetTranslation("pveroomlist.view.PVERoomItem.needGrades.text2",_areaInfo.getMapByDifficult(1).MinLevel,_areaInfo.getMapByDifficult(1).MaxLevel) + ")";
            }
            if(_areaInfo.getMapByDifficult(1).MinLevel > thane.grades)
            {
               buttonMode = false;
               filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               if(!ArmyManager.instance.thane.isHoly)
               {
                  if(_areaInfo.getMapByDifficult(1).NeedFourTransfer)
                  {
                     buttonMode = false;
                     filters = [UIFilter.getGrayFilter()];
                     return;
                  }
               }
               else if(ArmyManager.instance.thane.vocationGrades <= 0)
               {
                  if(_areaInfo.getMapByDifficult(1).NeedTransfer)
                  {
                     buttonMode = false;
                     filters = [UIFilter.getGrayFilter()];
                     return;
                  }
               }
               else if(!ArmyManager.instance.thane.isChangeJob)
               {
                  if(_areaInfo.getMapByDifficult(1).NeedChangeJob)
                  {
                     buttonMode = false;
                     filters = [UIFilter.getGrayFilter()];
                     return;
                  }
               }
               else if(!ArmyManager.instance.thane.isAvenger)
               {
                  if(_areaInfo.getMapByDifficult(1).NeedThirdTransfer)
                  {
                     buttonMode = false;
                     filters = [UIFilter.getGrayFilter()];
                     return;
                  }
               }
               buttonMode = true;
               filters = null;
               initEvents();
            }
         }
         else
         {
            isOpen = false;
         }
      }
      
      private function setGradeImageAndText() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         var _loc2_:Component = null;
         var _loc3_:int = 0;
         var _loc6_:CampaignTemplate = null;
         _loc4_ = 0;
         while(_loc4_ < difficutlyCount)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("asset.room.InstanceItem.gradeImage" + _loc4_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("room.InstanceItem.gradeText" + _loc4_);
            _loc2_ = new Component();
            _loc3_ = 0;
            _loc2_.addChild(_loc5_);
            _loc2_.addChild(_loc1_);
            _loc6_ = _areaInfo.getMapByDifficult(_loc4_ + 1);
            if(_loc6_)
            {
               _loc3_ = getGradeByCampaignId(_loc6_.CampaignId);
            }
            if(gradeTextARR)
            {
               _loc1_.text = gradeTextARR[_loc3_];
            }
            _hbox.addChild(_loc2_);
            _loc4_++;
         }
         if(difficutlyCount == 1)
         {
            _hbox.x = 65;
         }
         else if(difficutlyCount == 2)
         {
            _hbox.spacing = 25;
            _hbox.x = 35;
         }
         else if(difficutlyCount == 3)
         {
            _hbox.spacing = 10;
            _hbox.x = 17;
         }
      }
      
      private function getGradeByCampaignId(param1:int) : int
      {
         var _loc2_:SimpleDictionary = CampaignRankManager.instance.rankDic;
         for each(var _loc3_:RankInfo in _loc2_)
         {
            if(_loc3_ && _loc3_.campaignId == param1)
            {
               return _loc3_.rank;
            }
         }
         return 0;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get areaInfo() : CampaignAreaInfo
      {
         return _areaInfo;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         if(!param1)
         {
            _bg.setFrame(1);
            _areaNameTxt.text = "";
            _mapIcon.visible = false;
            _areaInfo = null;
            removeEvents();
         }
      }
      
      public function playShine() : void
      {
         if(_isShineNow || _areaInfo == null)
         {
            return;
         }
         _selectBit.visible = true;
         _isShineNow = true;
         TweenMax.to(_selectBit,0.4,{
            "alpha":0,
            "repeat":-1,
            "yoyo":true
         });
      }
      
      public function stopShine(param1:Boolean = true) : void
      {
         _isShineNow = false;
         TweenMax.killTweensOf(_selectBit);
         _selectBit.alpha = 1;
         _selectBit.visible = param1;
      }
      
      public function dispose() : void
      {
         removeEvents();
         _areaInfo = null;
         if(_mapIcon)
         {
            _mapIcon.dispose();
         }
         _mapIcon = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_closeFont)
         {
            ObjectUtils.disposeObject(_closeFont);
         }
         _closeFont = null;
         if(_selectBit)
         {
            ObjectUtils.disposeObject(_selectBit);
         }
         _selectBit = null;
         if(_instanceSp)
         {
            ObjectUtils.disposeObject(_instanceSp);
         }
         _instanceSp = null;
         if(_areaNameTxt)
         {
            ObjectUtils.disposeObject(_areaNameTxt);
         }
         _areaNameTxt = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         if(_alertGrades)
         {
            ObjectUtils.disposeObject(_alertGrades);
         }
         _alertGrades = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

