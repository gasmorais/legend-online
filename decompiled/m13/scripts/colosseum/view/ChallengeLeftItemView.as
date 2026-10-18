package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import mvc.module.sort.SortData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerInfoManager;
   import yishi.view.community.HeadIconCell;
   
   public class ChallengeLeftItemView extends Sprite implements Disposeable
   {
      
      private var _data:SortData;
      
      private var _index:int;
      
      private var _icon:HeadIconCell;
      
      private var _bg:ScaleFrameImage;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _thaneNameTxt:FilterFrameText;
      
      public function ChallengeLeftItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("colosseum.HeadIconCell");
         _bg = ComponentFactory.Instance.creatComponentByStylename("colosseum.ChallengeLeftItemBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("colosseum.challengeLeftItemTitle");
         _thaneNameTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.challengeLeftView.thanename");
         addChild(_icon);
         addChild(_bg);
         addChild(_titleImg);
         addChild(_thaneNameTxt);
         _thaneNameTxt.mouseEnabled = true;
         _thaneNameTxt.htmlText = "<u>" + LanguageMgr.GetTranslation("colosseum.view.defaultThaneName") + "</u>";
         _icon.headId = 5;
         _bg.setFrame(1);
         _titleImg.setFrame(1);
      }
      
      private function initEvent() : void
      {
         _thaneNameTxt.addEventListener("link",__thaneNameTxtHandler);
      }
      
      private function removeEvent() : void
      {
         if(_thaneNameTxt)
         {
            _thaneNameTxt.removeEventListener("link",__thaneNameTxtHandler);
         }
      }
      
      private function __thaneNameTxtHandler(param1:TextEvent) : void
      {
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.userId = _data.army.baseHero.userId;
         _loc2_.nickName = _data.army.baseHero.nickName;
         _loc2_.playerOrdeInfo.gpOrder = _data.army.baseHero.playerOrdeInfo.gpOrder;
         _loc2_.grades = _data.army.baseHero.grades;
         _loc2_.gp = _data.army.baseHero.gp;
         _loc2_.templateId = _data.army.baseHero.templateId;
         PlayerInfoManager.instance.show(_loc2_);
      }
      
      public function set data(param1:SortData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _thaneNameTxt.htmlText = "<a href=\'event:\'><u>" + _data.nikcName + "</u></a>";
         if(_index != 1)
         {
            _titleImg.setFrame(data.army.baseHero.templateInfo.Job + 1);
         }
         _icon.headId = data.army.baseHero.snsInfo.headId;
      }
      
      public function get data() : SortData
      {
         return _data;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         if(_index <= 1)
         {
            _bg.setFrame(1);
         }
         else
         {
            _bg.setFrame(2);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_thaneNameTxt);
         _thaneNameTxt = null;
      }
   }
}

