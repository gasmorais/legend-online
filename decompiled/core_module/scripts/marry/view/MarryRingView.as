package marry.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class MarryRingView extends Sprite implements Disposeable
   {
      
      private var _marryRing:BaseIconView;
      
      private var _levelBmp:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _upBtn:IconButton;
      
      private var _thane:ThaneInfo;
      
      private var _totalDay:Number = 1728000;
      
      private var g1:int;
      
      private var g2:int;
      
      public function MarryRingView(param1:ThaneInfo = null)
      {
         super();
         _thane = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _marryRing = ComponentFactory.Instance.creatCustomObject("playerinfo.ring");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("MarryRingView.upBtn");
         _levelBmp = ComponentFactory.Instance.creatBitmap("asset.core.fashionLevelSpecial");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ringLevelTxt");
         _levelBmp.x = 1;
         _levelBmp.y = 21;
         addChild(_marryRing);
         addChild(_levelBmp);
         addChild(_levelTxt);
         addChild(_upBtn);
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:MarryTipData = null;
         var _loc1_:int = 0;
         if(_thane)
         {
            _upBtn.visible = false;
            if(_thane.marryRingGrade > 0)
            {
               _marryRing.icon = IconFactory.getMarryRingIcon(_thane.marryRingGrade > 9 ? 9 : _thane.marryRingGrade);
               _marryRing.visible = true;
               _levelBmp.visible = true;
               _levelTxt.visible = true;
               _levelTxt.text = "" + _thane.marryRingGrade;
               _loc2_ = new MarryTipData();
               _loc2_.type = 2;
               _loc2_.grades = _thane.marryRingGrade;
               _loc2_.grades = _thane.marryRingGrade;
               _loc2_.nickNameB = _thane.nickNameB;
               _marryRing.tipStyle = "yishi.view.tips.MarryTip";
               _marryRing.tipData = _loc2_;
            }
            else if(StringHelper.isNullOrEmpty(_thane.nickNameB))
            {
               if(model.isDivorce)
               {
                  showDivorce(_thane.grades);
               }
               else if(model.isEnEngaged)
               {
                  if(model.marriageData.ringInfo.ringGrade == 0)
                  {
                     _marryRing.visible = false;
                  }
                  else
                  {
                     showDivorce(_thane.grades);
                  }
               }
               else
               {
                  _marryRing.visible = false;
               }
               _marryRing.visible = false;
               _levelBmp.visible = false;
               _levelTxt.visible = false;
            }
            else
            {
               _marryRing.icon = IconFactory.getMarryRingIcon(0);
               _marryRing.tipStyle = "yishi.view.tips.OneLineTip";
               _marryRing.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.MarryRingView.tipData1",_thane.nickName,_thane.nickNameB);
               _marryRing.visible = true;
               _levelBmp.visible = false;
               _levelTxt.visible = false;
            }
         }
         else if(model.marriangeState != 0)
         {
            _loc1_ = model.marriageData.ringInfo.ringGrade;
            _marryRing.visible = true;
            _marryRing.icon = IconFactory.getMarryRingIcon(_loc1_ > 9 ? 9 : _loc1_);
            _levelBmp.visible = true;
            _levelTxt.visible = true;
            _upBtn.visible = true;
            _upBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.MarryRingView.tipData3");
            _levelTxt.text = "" + _loc1_;
            _loc2_ = new MarryTipData();
            _loc2_.type = 2;
            _loc2_.grades = _loc1_;
            _loc2_.nickNameB = MarryManager.instance.model.selfMarryInfo.nickName;
            if(model.marriangeState == 4)
            {
               _loc2_.nickNameB = null;
            }
            _marryRing.tipStyle = "yishi.view.tips.MarryTip";
            _marryRing.tipData = _loc2_;
            if(model.marriangeState == 4)
            {
            }
         }
         else
         {
            _marryRing.visible = false;
            _levelBmp.visible = false;
            _levelTxt.visible = false;
            _upBtn.visible = false;
         }
      }
      
      private function initEvent() : void
      {
         if(_upBtn && _thane == null)
         {
            _upBtn.addEventListener("click",__upHandler);
         }
      }
      
      private function showDivorce(param1:int) : void
      {
         _marryRing.icon = IconFactory.getMarryRingIcon(param1 > 9 ? 9 : param1);
         _marryRing.visible = true;
         _marryRing.tipStyle = "yishi.view.tips.OneLineTip";
         g1 = param1 - 2;
         g2 = param1 - 4;
         if(param1 < 3)
         {
            param1 = 3;
         }
         if(g1 < 2)
         {
            g1 = 2;
         }
         if(g2 < 1)
         {
            g2 = 1;
         }
         _marryRing.tipData = LanguageMgr.GetTranslation("marry.view.MarryRingView.Divorce",param1,g1,g2);
      }
      
      private function __upHandler(param1:Event) : void
      {
         MarryManager.instance.creatRingUpFrame();
      }
      
      private function removeEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upHandler);
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      public function get upButton() : IconButton
      {
         return _upBtn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_marryRing)
         {
            _marryRing.dispose();
         }
         _marryRing = null;
         if(_levelTxt)
         {
            _levelTxt.dispose();
         }
         _levelTxt = null;
         if(_upBtn)
         {
            _upBtn.dispose();
         }
         _upBtn = null;
         ObjectUtils.disposeObject(_levelBmp);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

