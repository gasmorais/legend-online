package apex.guess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.apex.ApexRankTeamData;
   
   public class ApexGuessListItem extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _txtGuessItemStr1:FilterFrameText;
      
      private var _txtGuessItemStr2:FilterFrameText;
      
      private var _txtGuessItemStr3:FilterFrameText;
      
      private var _txtGuessItemRank:FilterFrameText;
      
      private var _txtGuessItemFightPower:FilterFrameText;
      
      private var _txtGuessItemStrArea:FilterFrameText;
      
      private var _btnGuessSelect:IconButton;
      
      private var _btnGuessItemPlayer:ScaleFrameImage;
      
      private var _txtGuessItemPlayerName:FilterFrameText;
      
      private var detailArr:Array;
      
      public var clickback:Function;
      
      public var selectback:Function;
      
      private var _data:ApexRankTeamData;
      
      public function ApexGuessListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.kuang");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.fplight");
         _txtGuessItemStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemStr1");
         _txtGuessItemStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemStr2");
         _txtGuessItemStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemStr3");
         _txtGuessItemRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemRank");
         _txtGuessItemFightPower = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemFightPower");
         _txtGuessItemStrArea = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemStrArea");
         _btnGuessSelect = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnGuessSelect");
         _btnGuessItemPlayer = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnGuessItemPlayer");
         _txtGuessItemPlayerName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessItemPlayerName");
         addChild(_bit0);
         addChild(_bit1);
         addChild(_txtGuessItemStr1);
         addChild(_txtGuessItemStr2);
         addChild(_txtGuessItemStr3);
         addChild(_txtGuessItemRank);
         addChild(_txtGuessItemFightPower);
         addChild(_txtGuessItemStrArea);
         addChild(_btnGuessSelect);
         addChild(_btnGuessItemPlayer);
         addChild(_txtGuessItemPlayerName);
         _btnGuessItemPlayer.buttonMode = true;
         _txtGuessItemStr1.text = LanguageMgr.GetTranslation("apex.guess.item.str1");
         _txtGuessItemStr2.text = LanguageMgr.GetTranslation("apex.guess.item.str2");
         _txtGuessItemStr3.text = LanguageMgr.GetTranslation("apex.guess.item.str3");
         detailArr = [];
         detailArr.push(_bit0);
         detailArr.push(_bit1);
         detailArr.push(_txtGuessItemStr1);
         detailArr.push(_txtGuessItemStr2);
         detailArr.push(_txtGuessItemStr3);
         detailArr.push(_txtGuessItemRank);
         detailArr.push(_txtGuessItemFightPower);
         detailArr.push(_txtGuessItemStrArea);
         detailArr.push(_btnGuessSelect);
         show(false);
         addEvent();
      }
      
      private function addEvent() : void
      {
         _btnGuessItemPlayer.addEventListener("click",onClickItem);
         _btnGuessSelect.addEventListener("click",onClickSelect);
      }
      
      private function removeEvent() : void
      {
         _btnGuessItemPlayer.removeEventListener("click",onClickItem);
         _btnGuessSelect.removeEventListener("click",onClickSelect);
      }
      
      public function set canBet(param1:Boolean) : void
      {
         _btnGuessSelect.enable = param1;
      }
      
      public function set data(param1:ApexRankTeamData) : void
      {
         _data = param1;
         if(_data)
         {
            _txtGuessItemPlayerName.text = _data.teamName;
            _txtGuessItemFightPower.text = _data.fightCapacity + "";
            _txtGuessItemRank.text = _data.rank + "";
            _txtGuessItemStrArea.text = _data.serverName;
         }
      }
      
      protected function onClickSelect(param1:MouseEvent) : void
      {
         selectback.apply(null,[_data]);
      }
      
      protected function onClickItem(param1:MouseEvent) : void
      {
         clickback.apply(null,[this]);
      }
      
      public function show(param1:Boolean) : void
      {
         for each(var _loc2_:DisplayObject in detailArr)
         {
            if(param1)
            {
               addChild(_loc2_);
               _btnGuessItemPlayer.setFrame(2);
            }
            else
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _btnGuessItemPlayer.setFrame(1);
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         detailArr = null;
         clickback = null;
         selectback = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_txtGuessItemStr1);
         _txtGuessItemStr1 = null;
         ObjectUtils.disposeObject(_txtGuessItemStr2);
         _txtGuessItemStr2 = null;
         ObjectUtils.disposeObject(_txtGuessItemStr3);
         _txtGuessItemStr3 = null;
         ObjectUtils.disposeObject(_txtGuessItemRank);
         _txtGuessItemRank = null;
         ObjectUtils.disposeObject(_txtGuessItemFightPower);
         _txtGuessItemFightPower = null;
         ObjectUtils.disposeObject(_txtGuessItemStrArea);
         _txtGuessItemStrArea = null;
         ObjectUtils.disposeObject(_btnGuessSelect);
         _btnGuessSelect = null;
         ObjectUtils.disposeObject(_btnGuessItemPlayer);
         _btnGuessItemPlayer = null;
         ObjectUtils.disposeObject(_txtGuessItemPlayerName);
         _txtGuessItemPlayerName = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

